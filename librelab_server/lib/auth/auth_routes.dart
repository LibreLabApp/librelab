import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart'
    hide AuthToken, Permission, Role, User;
import 'package:librelab_api_contract/librelab_api_contract.dart' as dto;
import 'package:librelab_server/auth/auth_service.dart';
import 'package:librelab_server/auth/security/jwt/jwt_service.dart';
import 'package:librelab_server/user/refresh_token/user_refresh_token.dart';
import 'package:librelab_server/user/role/role.dart';
import 'package:librelab_server/user/user.dart';
import 'package:librelab_server/utils/is_debug_mode.dart';
import 'package:librelab_server/utils/json_http_extensions.dart';
import 'package:librelab_server/utils/request_ext.dart';
import 'package:librelab_server/utils/route_module.dart';
import 'package:librelab_server/utils/router_ext.dart';
import 'package:librelab_shared/result.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class AuthRoutes implements RouteModule {
  AuthRoutes({required this._service});

  final AuthService _service;

  @override
  Router get router => Router()
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
      case SuccessResult<LoginResult, UserLoginFailure>(:final value):
        final (user, tokens) = (value.$1, value.$2);

        final response = LoginResponse(
          accessToken: tokens.accessToken._toResponse(),
          refreshToken: tokens.refreshTokenRaw._toResponse(),
          user: user._toResponse(),
        );

        return response.toJson().httpResponse(.ok);

      case FailureResult<LoginResult, UserLoginFailure>(:final failure):
        switch (failure) {
          case UserNotFoundFailure():
          case InvalidPasswordFailure():
            return const ServerErrorResponse(
              message: AuthErrorCodes.invalidCredentials,
              code:
                  'Invalid credentials (email not found or password is incorrect)',
            ).toJson().httpResponse(.unauthorized);
          case InvalidLoginInputFailure():
            return const ServerErrorResponse(
              message: 'INVALID_LOGIN_INPUT',
              code: 'Invalid login input',
            ).toJson().httpResponse(.badRequest);
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
      metadata: _clientMetadata(request, body.deviceId),
    );
    switch (result) {
      case SuccessResult<AuthTokens, RefreshTokenFailure>(:final value):
        return RefreshTokenResponse(
          accessToken: value.accessToken._toResponse(),
          refreshToken: value.refreshTokenRaw._toResponse(),
        ).toJson().httpResponse(.ok);
      case FailureResult<AuthTokens, RefreshTokenFailure>(:final failure):
        final (code, message) = switch (failure) {
          TokenNotFoundFailure() => (
            AuthErrorCodes.tokenNotFound,
            'The refresh token was not found. '
                'The refresh token and/or the user may have been removed.',
          ),
          TokenExpiredFailure() => (
            AuthErrorCodes.tokenExpired,
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

  Future<Response> _refreshUserHandler(Request request) async {
    // TODO: (REMOVE_SERVERPOD) Extract into a utility before start using that everywhere

    final token = request.extractBearerToken();
    if (token == null) {
      return const ServerErrorResponse(
        message:
            'The access token must be provided in the headers (Authorization: Bearer ...)',
        code: 'TOKEN_MISSING',
      ).toJson().httpResponse(.badRequest);
    }
    final result = await _service.authenticateWithFullUser(accessToken: token);
    switch (result) {
      case SuccessResult<User, AuthenticateFailure>(:final value):
        return value._toResponse().toJson().httpResponse(.ok);

      case FailureResult<User, AuthenticateFailure>(:final failure):
        final (code, message) = switch (failure) {
          JwtAuthenticationFailure(:final failure) => switch (failure) {
            JwtExpiredFailure() => ('TOKEN_EXPIRED', 'Token expired'),
            JwtSignatureVerificationFailure() => (
              'INVALID_TOKEN_SIGNATURE',
              'Token signature verification failed',
            ),
            JwtParseFailure() => (
              'INVALID_TOKEN_FORMAT',
              'Invalid token format/structure',
            ),
            JwtUnknownFailure(:final message) => (
              'UNKNOWN',
              kDebugMode ? message.toString() : 'Unknown token parsing failure',
            ),
          },
          UserDeletedFailure() => (
            'USER_NOT_FOUND',
            'User not found (may have been deleted)',
          ),
          TokenVersionMismatchFailure() => (
            'TOKEN_REVOKED',
            'Token revoked (version mismatch)',
          ),
        };
        return ServerErrorResponse(
          message: message,
          code: code,
        ).toJson().httpResponse(.unauthorized);
    }
  }

  UserRefreshTokenClientMetadata _clientMetadata(
    Request request,
    String? deviceId,
  ) => .new(
    deviceId: deviceId,
    ipAddress: request.ipAddress,
    userAgent: request.userAgent,
  );
}

extension on AuthToken {
  dto.AuthToken _toResponse() => .new(token: token, expiresAt: expiresAt);
}

extension on User {
  dto.User _toResponse() => .new(
    id: id,
    email: email,
    fullName: fullName,
    phoneNumber: phoneNumber,
    isSuperUser: isSuperUser,
    role: role?._toResponse(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension on Role {
  dto.Role _toResponse() => .new(
    id: id,
    name: name,
    permissions: permissions.map((e) => e._toResponse()).toList(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension on Permission {
  dto.Permission _toResponse() => switch (this) {
    .backupCreate => .backupCreate,
    .backupRestore => .backupRestore,
  };
}
