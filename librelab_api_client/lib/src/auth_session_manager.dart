import 'package:api_client/api_client.dart';
import 'package:dart_build_constants/dart_build_constants.dart';
import 'package:librelab_api_client/src/auth_session.dart';
import 'package:librelab_api_client/src/exceptions.dart';
import 'package:librelab_api_client/src/librelab_api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

typedef AuthSessionRefreshedCallback = Future<void> Function(
  AuthSession session,
);

class AuthSessionManager({
  required final AuthEndpoints _authEndpoints,
  required final Logger? _logger,
  required final AuthSessionRefreshedCallback _onAuthSessionRefreshed,
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

  /// Returns the authorization headers for [session].
  ///
  /// Returns the access token as a Bearer token for [AuthSessionMemory].
  /// Returns `null` for [AuthSessionBrowserCookie] because the browser
  /// automatically sends the authentication cookies with the request.
  Map<String, String>? _authorizationHeaders(AuthSession session) {
    return switch (session) {
      AuthSessionMemory(:final accessToken) => {
        ApiHttpHeaders.authorization:
            '${ApiHttpHeaders.bearerPrefix}${accessToken.value}',
      },
      AuthSessionBrowserCookie() => null,
    };
  }

  /// Whether an authentication error should trigger an automatic token refresh.
  ///
  /// - Browser clients: attempt one refresh because the browser may have
  /// silently removed an expired HttpOnly access-token cookie while
  /// the refresh-token cookie may still be valid.
  ///
  /// - Non-browser clients: explicitly send the access token in the
  /// Authorization header, allowing the server to distinguish an
  /// expired access token from a missing one.
  bool _shouldAttemptTokenRefresh(String code) =>
      code == AuthErrorCodes.accessTokenExpired ||
      (kIsWeb && code == AuthErrorCodes.unauthenticated);

  Future<LibreLabApiResult<S>> requestAuthenticated<S>(
    HttpEndpoint endpoint, {
    required AuthenticatedRequest<S> request,
    required Map<String, String>? headers,
    required AuthSession? overrideAuthSession,
    @mustBeConst required bool enableAutoTokenRefresh,
  }) async {
    final session = overrideAuthSession ?? _authSession;

    if (session == null) {
      throw StateError('Auth session is required to make this request.');
    }

    final requestContext = AuthenticatedRequestContext(
      authSession: session,
      headers: {...?headers, ...?_authorizationHeaders(session)},
    );

    if (session.isAccessTokenExpired() ?? false) {
      return _refreshSessionAndRequest(
        endpoint,
        authSession: session,
        request: request,
        headers: headers,
        enableAutoTokenRefresh: enableAutoTokenRefresh,
      );
    }

    final result = await request(requestContext);

    switch (result) {
      case HttpStatusSuccess():
        return result;

      case HttpStatusError(:final response):
        final code = response.body.code;

        if (_shouldAttemptTokenRefresh(code)) {
          return _refreshSessionAndRequest(
            endpoint,
            authSession: session,
            request: request,
            headers: headers,
            enableAutoTokenRefresh: enableAutoTokenRefresh,
          );
        }

        if (code == AuthErrorCodes.reAuthenticationRequired) {
          throw AuthApiException.sessionInvalidated(
            session,
            .serverDetermined(
              _reAuthenticationRequiredReason(response.body),
              response.body.message,
              isDuringTokenRefresh: false,
            ),
          );
        }

        return result;
    }
  }

  String? _reAuthenticationRequiredReason(ServerErrorResponse response) {
    final reason = response.details?[AuthErrorDetailsKeys.reason] as String?;
    if (reason == null) {
      final message =
          'When error code is ${AuthErrorCodes.reAuthenticationRequired}, the reason must be provided in the details.\n'
          'Response: $response';
      if (kDebugMode) {
        throw StateError('(DEBUG_BUILD_ONLY) $message');
      }

      _logger?.warning(message);
    }

    return reason;
  }

  /// Refreshes the token and then sends the request.
  ///
  /// Must be called when the access token has expired. Part of [requestAuthenticated].
  Future<LibreLabApiResult<S>> _refreshSessionAndRequest<S>(
    HttpEndpoint endpoint, {
    required AuthenticatedRequest<S> request,
    required AuthSession authSession,
    required Map<String, String>? headers,
    required bool enableAutoTokenRefresh,
  }) async {
    if (!enableAutoTokenRefresh) {
      throw StateError(
        'Access token is expired but enableAutoTokenRefresh is false',
      );
    }

    if (authSession.isRefreshTokenExpired() ?? false) {
      throw AuthApiException.sessionInvalidated(
        authSession,
        const .expiredByLocalCheck(),
      );
    }

    final refreshedSession = await _refreshSessionDeduplicated(authSession);

    return requestAuthenticated(
      endpoint,
      request: request,
      headers: headers,
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

  /// Refreshes the given authentication session.
  ///
  /// Concurrent refresh requests share the same in-flight refresh operation.
  Future<AuthSession> _refreshSessionDeduplicated(
    AuthSession authSession,
  ) async {
    return _refreshSessionFuture ??= _refreshSession(authSession)
        .whenComplete(() {
          _refreshSessionFuture = null;
        });
  }

  Future<AuthSession> _refreshSession(AuthSession authSession) async {
    final versionBeforeRefresh = _sessionVersion;

    switch (authSession) {
      case AuthSessionMemory(:final refreshToken):
        switch (await _refresh(refreshToken.value)) {
          case HttpStatusSuccess(:final response):
            final refreshedSession = authSession.copyWith(
              accessToken: response.body.accessToken,
              refreshToken: response.body.refreshToken,
            );

            if (versionBeforeRefresh == _sessionVersion) {
              _authSession = refreshedSession;
              await _onAuthSessionRefreshed.call(refreshedSession);
            } else {
              _logger?.fine(
                'Session version changed during refresh. Global auth session update skipped.\n'
                'Refreshed session applied only to current in-flight request.\n'
                'versionBeforeRefresh=$versionBeforeRefresh, currentSessionVersion=$_sessionVersion',
              );
            }
            return refreshedSession;
          case HttpStatusError(:final response):
            _handleRefreshTokenError(response, authSession: authSession);
        }

      case AuthSessionBrowserCookie():
        switch (await _refreshBrowser()) {
          case HttpStatusSuccess():
            return authSession;
          case HttpStatusError(:final response):
            return _handleRefreshTokenError(response, authSession: authSession);
        }
    }
  }

  Never _handleRefreshTokenError(
    HttpResponse<ServerErrorResponse> response, {
    required AuthSession authSession,
  }) {
    final code = response.body.code;

    if (code == AuthErrorCodes.reAuthenticationRequired) {
      throw AuthApiException.sessionInvalidated(
        authSession,
        .serverDetermined(
          _reAuthenticationRequiredReason(response.body),
          response.body.message,
          isDuringTokenRefresh: true,
        ),
      );
    }

    throw AuthApiException.refreshTokenRequest(response);
  }

  Future<LibreLabApiResult<RefreshAuthResponse>> _refresh(
    String refreshToken,
  ) => _authEndpoints.refresh(RefreshAuthRequest(refreshToken: refreshToken));

  Future<LibreLabApiResult<void>> _refreshBrowser() =>
      _authEndpoints.browser.refresh();
}

typedef AuthenticatedRequest<T> = Future<LibreLabApiResult<T>> Function(
  AuthenticatedRequestContext context,
);

@immutable
class const AuthenticatedRequestContext({
  required final AuthSession authSession,
  required final Map<String, String> headers,
});
