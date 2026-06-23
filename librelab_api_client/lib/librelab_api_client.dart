// TODO: (REMOVE_SERVERPOD) Implement handshake
// TODO: (REMOVE_SERVERPOD) User agent

import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:clock/clock.dart' show clock;
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:result/result.dart';

/// Reason a session was invalidated during refresh flow.
///
/// Client-side + server-side outcomes for refresh token failure.
enum SessionInvalidationReason {
  /// Local expiry check marked refresh token as expired before request (expiresAt field).
  expiredByLocalCheck,

  /// Server responded that refresh token is expired.
  expiredByServer,

  /// Server did not find the refresh token (revoked/removed/user deleted)
  /// during token refresh.
  refreshTokenNotFound,

  /// The access token is not expired yet but the user was not found.
  userNotFound,
}

class LibreLabApiClient {
  LibreLabApiClient({
    required this._apiClient,
    required this._logger,
    required this._baseUrl,
    required this._onSessionInvalidated,
    required this._onSessionRefreshed,
  });

  final ApiClient _apiClient;
  final Logger? _logger;
  final Future<void> Function(
    AuthSession session,
    SessionInvalidationReason reason,
  )
  _onSessionInvalidated;
  final Future<void> Function(AuthSession session) _onSessionRefreshed;

  Uri _baseUrl;
  AuthSession? _authSession;

  /// Incremented on each auth session change to prevent in-flight refreshes
  /// from overriding the updated [AuthSession] (race condition).
  int _sessionVersion = 0;

  void setBaseUrl(Uri baseUrl, AuthSession? authSession) {
    _baseUrl = baseUrl;
    _authSession = authSession;
  }

  void setAuthSession(AuthSession? session) {
    _sessionVersion++;
    _authSession = session;
  }

  Uri get baseUrl => _baseUrl;
  AuthSession? get authSession => _authSession;

  Future<Result<HttpResponse<S>, AuthApiFailure>> requestAuthenticated<S>(
    HttpEndpoint endpoint, {
    Map<String, Iterable<String>>? queryParameters,
    Map<String, String>? headers,
    RequestBody? body,
    required JsonResponseDeserializer<S> deserializeSuccess,
    AuthSession? authSession,
    bool enableAutoTokenRefresh = true,
  }) async {
    final session = authSession ?? _authSession;

    if (session == null) {
      throw StateError('Auth session is required to make this request.');
    }

    if (_isTokenExpired(session.accessToken.expiresAt)) {
      return _refreshSessionAndRequest(
        authSession: session,
        endpoint: endpoint,
        body: body,
        headers: headers,
        queryParameters: queryParameters,
        deserializeSuccess: deserializeSuccess,
        enableAutoTokenRefresh: enableAutoTokenRefresh,
      );
    }

    final result = await request(
      endpoint,
      body: body,
      queryParameters: queryParameters,
      deserializeSuccess: deserializeSuccess,
      headers: {
        ...?headers,
        ApiHttpHeaders.authorization:
            ApiHttpHeaders.bearerPrefix + session.accessToken.token,
      },
    );

    switch (result) {
      case SuccessResult<HttpResponse<S>, ApiFailure<ServerErrorResponse>>(
        :final value,
      ):
        return .success(value);
      case FailureResult<HttpResponse<S>, ApiFailure<ServerErrorResponse>>(
        :final failure,
      ):
        switch (failure) {
          case ConnectionFailure<ServerErrorResponse>():
          case UnexpectedFailure<ServerErrorResponse>():
          case JsonDecodingFailure<ServerErrorResponse>():
          case JsonDeserializationFailure<ServerErrorResponse>():
            return .failure(RequestApiFailureWrapped(failure));

          case HttpStatusFailure<ServerErrorResponse>(:final response):
            final code = response.body.code;
            if (code == AuthErrorCodes.userNotFound) {
              await _onSessionInvalidated(session, .userNotFound);
              return .failure(const SessionExpiredFailure());
            }
            if (code == AuthErrorCodes.accessTokenExpired) {
              return _refreshSessionAndRequest(
                authSession: session,
                endpoint: endpoint,
                body: body,
                headers: headers,
                queryParameters: queryParameters,
                deserializeSuccess: deserializeSuccess,
                enableAutoTokenRefresh: enableAutoTokenRefresh,
              );
            }

            return .failure(RequestApiFailureWrapped(failure));
        }
    }
  }

  Future<JsonApiResult<S, ServerErrorResponse>> request<S>(
    HttpEndpoint endpoint, {
    Map<String, Iterable<String>>? queryParameters,
    Map<String, String>? headers,
    RequestBody? body,
    required JsonResponseDeserializer<S> deserializeSuccess,
  }) async {
    final url = _baseUrl.replace(
      path: endpoint.path,
      queryParameters: queryParameters,
    );

    final result = await _apiClient.requestJson(
      url,
      method: endpoint.method,
      body: body,
      deserializeSuccess: deserializeSuccess,
      deserializeFailure: (response) =>
          ServerErrorResponse.fromJson(response.body),
      headers: headers,
    );

    return result;
  }

  /// Refreshes the token and then sends the request.
  ///
  /// Must be called when the access token has expired. Part of [requestAuthenticated].
  Future<Result<HttpResponse<S>, AuthApiFailure>> _refreshSessionAndRequest<S>({
    required AuthSession authSession,
    required HttpEndpoint endpoint,
    required Map<String, Iterable<String>>? queryParameters,
    required Map<String, String>? headers,
    required RequestBody? body,
    required JsonResponseDeserializer<S> deserializeSuccess,
    required bool enableAutoTokenRefresh,
  }) async {
    if (!enableAutoTokenRefresh) {
      throw StateError(
        'Access token is expired but enableAutoTokenRefresh = $enableAutoTokenRefresh',
      );
    }

    if (_isTokenExpired(authSession.refreshToken.expiresAt)) {
      await _onSessionInvalidated(authSession, .expiredByLocalCheck);
      return .failure(const SessionExpiredFailure());
    }

    final result = await _refreshSessionDeduplicated(authSession);

    switch (result) {
      case SuccessResult<AuthSession, AuthApiFailure>(
        value: final refreshedSession,
      ):
        return requestAuthenticated(
          endpoint,
          body: body,
          headers: headers,
          queryParameters: queryParameters,
          deserializeSuccess: deserializeSuccess,
          // Always uses the refreshed session for this request regardless
          // of the version check above (which affects future requests)
          authSession: refreshedSession,
          // Prevents refreshing again (to avoid refresh loops).
          // Expects the access token to be valid after a successful refresh.
          enableAutoTokenRefresh: false,
        );
      case FailureResult<AuthSession, AuthApiFailure>(:final failure):
        return .failure(failure);
    }
  }

  /// For [_refreshSessionDeduplicated]
  Future<Result<AuthSession, AuthApiFailure>>? _refreshSessionFuture;

  /// Handles deduplication automatically.
  /// Concurrent calls share a single in-flight refresh.
  Future<Result<AuthSession, AuthApiFailure>> _refreshSessionDeduplicated(
    AuthSession authSession,
  ) async {
    return _refreshSessionFuture ??= _refreshSession(authSession).whenComplete(
      () {
        _refreshSessionFuture = null;
      },
    );
  }

  Future<Result<AuthSession, AuthApiFailure>> _refreshSession(
    AuthSession authSession,
  ) async {
    final versionBeforeRefresh = _sessionVersion;

    final refreshResult = await _refreshToken(authSession.refreshToken.token);

    switch (refreshResult) {
      case SuccessResult<
        HttpResponse<RefreshTokenResponse>,
        ApiFailure<ServerErrorResponse>
      >(
        value: final response,
      ):
        final refreshedSession = authSession.copyWith(
          accessToken: response.body.accessToken,
          refreshToken: response.body.refreshToken,
        );

        if (versionBeforeRefresh == _sessionVersion) {
          _authSession = refreshedSession;
          await _onSessionRefreshed(refreshedSession);
        } else {
          _logger?.fine(
            'Session version changed during refresh. Global auth session update skipped.\n'
            'Refreshed session applied only to current in-flight request.\n'
            'versionBeforeRefresh=$versionBeforeRefresh, currentSessionVersion=$_sessionVersion',
          );
        }

        return .success(refreshedSession);
      case FailureResult<
        HttpResponse<RefreshTokenResponse>,
        ApiFailure<ServerErrorResponse>
      >(
        :final failure,
      ):
        if (failure case HttpStatusFailure<ServerErrorResponse>(
          :final response,
        )) {
          final code = response.body.code;

          if (AuthErrorCodes.isInvalidRefreshToken(code)) {
            await _onSessionInvalidated(authSession, switch (code) {
              AuthErrorCodes.refreshTokenNotFound => .refreshTokenNotFound,
              AuthErrorCodes.refreshTokenExpired => .expiredByServer,
              String() => () {
                assert(() {
                  throw StateError('Unknown response code: $code');
                }(), null);

                const fallback = SessionInvalidationReason.refreshTokenNotFound;

                _logger?.warning(
                  'Unknown auth error response code: $code\n'
                  'Falling back to: $fallback',
                );

                return fallback;
              }(),
            });
            return .failure(const SessionExpiredFailure());
          }
        }

        return .failure(RefreshApiFailureWrapped(failure));
    }
  }

  Future<_RefreshTokenResult> _refreshToken(String refreshToken) async {
    final result = await request(
      ApiEndpointDefinitions.auth_refresh_token$POST,
      body: .json(RefreshTokenRequest(refreshToken: refreshToken).toJson()),
      deserializeSuccess: (response) =>
          RefreshTokenResponse.fromJson(response.body),
    );

    return result;
  }
}

typedef _RefreshTokenResult =
    JsonApiResult<RefreshTokenResponse, ServerErrorResponse>;

@immutable
class const AuthSession({
  required final String userId,
  required final AuthToken accessToken,
  required final AuthToken refreshToken,
}) {
  AuthSession copyWith({AuthToken? accessToken, AuthToken? refreshToken}) {
    return AuthSession(
      userId: userId,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}

/// Returns the current time in UTC.
DateTime _timeNowUTC() {
  return clock.now().toUtc();
}

/// Includes an optional [buffer] to catch tokens about to expire (in flight).
bool _isTokenExpired(
  DateTime expiresAt, {
  Duration buffer = const Duration(seconds: 10),
}) {
  final now = _timeNowUTC();
  if (!expiresAt.isUtc) {
    throw ArgumentError(
      'expiresAt must be in UTC. Received: $expiresAt '
      '(isUtc: ${expiresAt.isUtc}).',
    );
  }

  return now.add(buffer).isAfter(expiresAt);
}

/// For authenticated requests with automatic token refresh support.
///
/// Used exclusively by [LibreLabApiClient.requestAuthenticated].
sealed class AuthApiFailure extends Failure {
  const AuthApiFailure(super.message);
}

/// The authenticated API request failed.
///
/// This is either the original request (no refresh was attempted)
/// or the retried request (after a token refresh).
final class RequestApiFailureWrapped extends AuthApiFailure {
  RequestApiFailureWrapped(this.wrapped) : super(wrapped.message);

  final ApiFailure<ServerErrorResponse> wrapped;

  @override
  String toString() => wrapped.toString();
}

/// The refresh token request failed (request was made due to expired access token).
final class RefreshApiFailureWrapped extends AuthApiFailure {
  RefreshApiFailureWrapped(this.wrapped) : super(wrapped.message);

  final ApiFailure<ServerErrorResponse> wrapped;

  @override
  String toString() => wrapped.toString();
}

/// The user was not found (probably deleted), or the session was revoked, or expired.
///
/// This will be returned instead of [RefreshApiFailureWrapped].
final class SessionExpiredFailure extends AuthApiFailure {
  const SessionExpiredFailure()
    : super('Session has been expired (re-authentication is required)');
}
