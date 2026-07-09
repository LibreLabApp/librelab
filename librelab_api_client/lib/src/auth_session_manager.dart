import 'package:api_client/api_client.dart';
import 'package:librelab_api_client/src/auth_session.dart';
import 'package:librelab_api_client/src/exceptions.dart';
import 'package:librelab_api_client/src/is_token_expired.dart';
import 'package:librelab_api_client/src/librelab_api_client.dart';
import 'package:librelab_api_client/src/session_invalidation_reason.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:logging/logging.dart';

typedef OnAuthSessionRefreshed = Future<void> Function(AuthSession session);

class AuthSessionManager(
  final LibreLabApiClient _client, {
  required final Logger? _logger,
  required final OnAuthSessionRefreshed? _onAuthSessionRefreshed,
}) {
  AuthSession? _authSession;
  AuthSession? get authSession => _authSession;

  /// Incremented on each auth session change to prevent in-flight refreshes
  /// from overriding the updated [AuthSession] (race condition).
  int _sessionVersion = 0;

  /// Sets [_authSession] and increments [_sessionVersion]
  /// prevent stale refreshes from overwriting newer sessions.
  void setAuthSession(AuthSession? session) {
    _sessionVersion++;
    _authSession = session;
  }

  Future<LibreLabApiResult<S>> requestAuthenticated<S>(
    HttpEndpoint endpoint, {
    required Map<String, Iterable<String>>? queryParameters,
    required Map<String, String>? headers,
    required RequestBody? body,
    required JsonResponseDeserializer<S> deserializeSuccess,
    required AuthSession? overrideAuthSession,
    required bool enableAutoTokenRefresh,
  }) async {
    final session = overrideAuthSession ?? _authSession;

    if (session == null) {
      throw StateError('Auth session is required to make this request.');
    }

    if (isTokenExpired(session.accessToken.expiresAt)) {
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

    final result = await _client.request(
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
      case HttpStatusSuccess():
        return result;
      case HttpStatusError(:final response):
        final code = response.body.code;
        if (code == AuthErrorCodes.userNotFound) {
          throw SessionExpiredException(session, .userNotFound);
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

        return result;
    }
  }

  /// Refreshes the token and then sends the request.
  ///
  /// Must be called when the access token has expired. Part of [requestAuthenticated].
  Future<LibreLabApiResult<S>> _refreshSessionAndRequest<S>({
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

    if (isTokenExpired(authSession.refreshToken.expiresAt)) {
      throw SessionExpiredException(authSession, .expiredByLocalCheck);
    }

    final refreshedSession = await _refreshSessionDeduplicated(authSession);

    return requestAuthenticated(
      endpoint,
      body: body,
      headers: headers,
      queryParameters: queryParameters,
      deserializeSuccess: deserializeSuccess,
      // Always uses the refreshed session for this request regardless
      // of the version check above (which affects future requests)
      overrideAuthSession: refreshedSession,
      // Prevents refreshing again (to avoid refresh loops).
      // Expects the access token to be valid after a successful refresh.
      enableAutoTokenRefresh: false,
    );
  }

  /// For [_refreshSessionDeduplicated]
  Future<AuthSession>? _refreshSessionFuture;

  /// Handles deduplication automatically.
  /// Concurrent calls share a single in-flight refresh.
  Future<AuthSession> _refreshSessionDeduplicated(
    AuthSession authSession,
  ) async {
    return _refreshSessionFuture ??= _refreshSession(authSession).whenComplete(
      () {
        _refreshSessionFuture = null;
      },
    );
  }

  Future<AuthSession> _refreshSession(AuthSession authSession) async {
    final versionBeforeRefresh = _sessionVersion;

    final refreshResult = await _refreshToken(authSession.refreshToken.token);

    switch (refreshResult) {
      case HttpStatusSuccess(:final response):
        final refreshedSession = authSession.copyWith(
          accessToken: response.body.accessToken,
          refreshToken: response.body.refreshToken,
        );

        if (versionBeforeRefresh == _sessionVersion) {
          _authSession = refreshedSession;
          await _onAuthSessionRefreshed?.call(refreshedSession);
        } else {
          _logger?.fine(
            'Session version changed during refresh. Global auth session update skipped.\n'
            'Refreshed session applied only to current in-flight request.\n'
            'versionBeforeRefresh=$versionBeforeRefresh, currentSessionVersion=$_sessionVersion',
          );
        }
        return refreshedSession;
      case HttpStatusError(:final response):
        final code = response.body.code;

        if (AuthErrorCodes.isInvalidRefreshToken(code)) {
          final SessionInvalidationReason reason = switch (code) {
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
          };
          throw SessionExpiredException(authSession, reason);
        }

        throw RefreshTokenRequestException(response);
    }
  }

  Future<LibreLabApiResult<RefreshAuthResponse>> _refreshToken(
    String refreshToken,
  ) => _client.endpoints.auth.refresh(
    RefreshAuthRequest(refreshToken: refreshToken),
  );
}
