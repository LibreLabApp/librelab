import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/auth/auth_service/auth_service.dart';
import 'package:librelab_server/auth/authorization_service.dart';
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
  required final AuthorizationService _authorization,
}) implements RouteModule {
  @override
  Router get router => .new()
    ..register(ApiEndpointDefinitions.auth_login$POST, _loginHandler)
    ..register(ApiEndpointDefinitions.auth_logout$POST, _logoutHandler)
    ..register(
      ApiEndpointDefinitions.auth_refresh_token$POST,
      _refreshTokenHandler,
    )
    ..register(
      ApiEndpointDefinitions.auth_refresh_user$POST,
      _refreshUserHandler,
    );

  Future<Response> _loginHandler(Request request) async {
    final body = await request.readJsonBody(fromJson: LoginRequest.fromJson);

    final result = await _service.loginUser(
      email: body.email,
      plainPassword: body.password,
      metadata: _clientMetadata(request, body.deviceId),
    );

    switch (result) {
      case SuccessResult<AuthenticatedSession, UserLoginFailure>(:final value):
        final (user, tokens) = value;

        final response = LoginResponse(
          accessToken: tokens.accessToken.toResponse(),
          refreshToken: tokens.refreshTokenRaw.toResponse(),
          user: user.toResponse(),
        );

        return response.toJson().httpResponse(.ok);

      case FailureResult<AuthenticatedSession, UserLoginFailure>(
        :final failure,
      ):
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
    final body = await request.readJsonBody(fromJson: LogoutRequest.fromJson);
    final revoked = await _service.logout(refreshTokenRaw: body.refreshToken);
    return LogoutResponse(tokenRevoked: revoked).toJson().httpResponse(.ok);
  }

  Future<Response> _refreshTokenHandler(Request request) async {
    final body = await request.readJsonBody(
      fromJson: RefreshTokenRequest.fromJson,
    );
    final result = await _service.refreshToken(
      refreshTokenRaw: body.refreshToken,
      metadata: (request.ipAddress, request.userAgent),
    );
    switch (result) {
      case SuccessResult<AuthTokens, RefreshTokenFailure>(:final value):
        return RefreshTokenResponse(
          accessToken: value.accessToken.toResponse(),
          refreshToken: value.refreshTokenRaw.toResponse(),
        ).toJson().httpResponse(.ok);
      case FailureResult<AuthTokens, RefreshTokenFailure>(:final failure):
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

  Future<Response> _refreshUserHandler(Request request) =>
      _authorization.withFullUser(request, (user) async {
        return user.toResponse().toJson().httpResponse(.ok);
      });

  UserRefreshTokenClientMetadata _clientMetadata(
    Request request,
    String? deviceId,
  ) => .new(
    deviceId: deviceId,
    ipAddress: request.ipAddress,
    userAgent: request.userAgent,
  );
}
