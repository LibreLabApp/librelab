import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/auth/auth_service/auth_service.dart';
import 'package:librelab_server/auth/browser/auth_browser_routes.dart';
import 'package:librelab_server/auth/refresh_token/user_refresh_token.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/request_ext.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:librelab_server/user/mapper.dart';
import 'package:librelab_shared/result.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthRoutes({
  required final AuthService _service,
  required final bool cookiesRequireSecureConnection,
}) implements RouteModule {
  late final AuthBrowserRoutes _browserRoutes = .new(
    cookiesRequireSecureConnection: cookiesRequireSecureConnection,
    login: _login,
    logout: _logout,
    refresh: _refresh,
  );

  @override
  Router get router => .new()
    ..register(ApiEndpointDefinitions.auth_login$POST, _loginHandler)
    ..register(ApiEndpointDefinitions.auth_logout$POST, _logoutHandler)
    ..register(ApiEndpointDefinitions.auth_refresh$POST, _refreshHandler)
    ..register(
      ApiEndpointDefinitions.auth_browser_login$POST,
      _browserRoutes.loginHandler,
    )
    ..register(
      ApiEndpointDefinitions.auth_browser_logout$POST,
      _browserRoutes.logoutHandler,
    )
    ..register(
      ApiEndpointDefinitions.auth_browser_refresh$POST,
      _browserRoutes.refreshHandler,
    );

  Future<Response> _loginHandler(Request request) => _login(
    request,
    success: (session) {
      final (user, tokens) = session;

      final response = LoginResponse(
        accessToken: tokens.accessToken.toResponse(),
        refreshToken: tokens.refreshTokenRaw.toResponse(),
        user: user.toResponse(),
      );

      return response.toJson().httpResponse(.ok);
    },
  );

  /// Shared between [_loginHandler] and [AuthBrowserRoutes.loginHandler]
  Future<Response> _login(
    Request request, {
    required Response Function(AuthenticatedSession session) success,
  }) async {
    final body = await request.readJsonBody(fromJson: LoginRequest.fromJson);

    final result = await _service.loginUser(
      email: body.email,
      plainPassword: body.password,
      metadata: _clientMetadata(request, body.deviceId),
    );

    switch (result) {
      case SuccessResult(:final value):
        return success(value);

      case FailureResult(:final failure):
        switch (failure) {
          case UserNotFoundFailure():
          case InvalidPasswordFailure():
            return const ServerErrorResponse(
              message: AuthErrorCodes.invalidLoginCredentials,
              code:
                  'Invalid login credentials (email not found or password is incorrect)',
            ).toJson().httpResponse(.unauthorized);
          case InvalidLoginInputFailure():
            return const ServerErrorResponse(
              message: 'INVALID_LOGIN_INPUT',
              code: 'Invalid login input',
            ).toJson().httpResponse(.badRequest);
          case LoginDisabledFailure():
            return const ServerErrorResponse(
              message: AuthErrorCodes.loginDisabled,
              code:
                  'Login is disabled. Contact system administrator to enable it.',
            ).toJson().httpResponse(.forbidden);
        }
    }
  }

  Future<Response> _logoutHandler(Request request) async {
    return _logout(
      request,
      readRefreshToken: () async {
        final body = await request.readJsonBody(
          fromJson: LogoutRequest.fromJson,
        );
        return body.refreshToken;
      },
      successHeaders: null,
    );
  }

  /// Shared between [_logoutHandler] and [AuthBrowserRoutes.logoutHandler]
  Future<Response> _logout(
    Request request, {
    required Future<String?> Function() readRefreshToken,
    required Map<String, Object> Function()? successHeaders,
  }) async {
    final refreshToken = await readRefreshToken();
    if (refreshToken == null || refreshToken.trim().isEmpty) {
      return _missingRefreshToken();
    }

    final revoked = await _service.logout(refreshTokenRaw: refreshToken);
    return LogoutResponse(
      tokenRevoked: revoked,
    ).toJson().httpResponse(.ok, headers: successHeaders?.call());
  }

  Future<Response> _refreshHandler(Request request) async {
    return _refresh(
      request,
      readRefreshToken: () async {
        final body = await request.readJsonBody(
          fromJson: RefreshAuthRequest.fromJson,
        );
        return body.refreshToken;
      },
      success: (tokens) {
        return RefreshAuthResponse(
          accessToken: tokens.accessToken.toResponse(),
          refreshToken: tokens.refreshTokenRaw.toResponse(),
        ).toJson().httpResponse(.ok);
      },
    );
  }

  /// Shared between [_refreshHandler] and [AuthBrowserRoutes.refreshHandler]
  Future<Response> _refresh(
    Request request, {
    required Future<String?> Function() readRefreshToken,
    required Response Function(AuthTokens tokens) success,
  }) async {
    final refreshToken = await readRefreshToken();
    if (refreshToken == null || refreshToken.trim().isEmpty) {
      return _missingRefreshToken();
    }

    final result = await _service.refreshToken(
      refreshTokenRaw: refreshToken,
      metadata: (request.ipAddress, request.userAgent),
    );
    switch (result) {
      case SuccessResult(:final value):
        return success(value);

      case FailureResult(:final failure):
        final (code, message) = switch (failure) {
          TokenNotFoundFailure() => (
            AuthErrorCodes.refreshTokenNotFound,
            'The refresh token was not found. '
                'The refresh token and/or the user may have been removed.',
          ),
          TokenExpiredFailure() => (
            AuthErrorCodes.refreshTokenExpired,
            'The refresh token has expired',
          ),
          UserMissingForValidTokenFailure() => (
            'USER_MISSING_FOR_VALID_TOKEN',
            'The refresh token is valid and found in the database but the corresponding user does not exist. '
                'This is likely a bug in the system.',
          ),
        };
        return ServerErrorResponse(
          message: message,
          code: code,
        ).toJson().httpResponse(.unauthorized);
    }
  }

  Response _missingRefreshToken() => const ServerErrorResponse(
    message: 'MISSING_REFRESH_TOKEN',
    code: 'Refresh token is required',
  ).toJson().httpResponse(.badRequest);

  UserRefreshTokenClientMetadata _clientMetadata(
    Request request,
    String? deviceId,
  ) => .new(
    deviceId: deviceId,
    ipAddress: request.ipAddress,
    userAgent: request.userAgent,
  );
}
