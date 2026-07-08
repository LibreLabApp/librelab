import 'dart:async';

import 'package:librelab_api_contract/librelab_api_contract.dart'
    show AuthErrorCodes, PermissionJson, ServerErrorResponse;
import 'package:librelab_server/auth/auth_service/auth_service.dart';
import 'package:librelab_server/auth/browser/auth_cookie_names.dart';
import 'package:librelab_server/auth/browser/request_cookies.dart';
import 'package:librelab_server/auth/security/jwt/jwt_service.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/request_ext.dart';
import 'package:librelab_server/user/role/mapper.dart';
import 'package:librelab_server/user/role/role.dart';
import 'package:librelab_server/user/user.dart';
import 'package:librelab_server/utils/is_debug_mode.dart';
import 'package:librelab_shared/result.dart';
import 'package:shelf/shelf.dart';

/// Intended exclusively for API server authorization layer (Shelf, HTTP responses).
/// Returns HTTP responses directly (not transport-agnostic).
class AuthorizationService({required final AuthService _authService}) {
  Future<Response> withAuthUser(
    Request request,
    FutureOr<Response> Function(AuthUser user) handler,
  ) {
    return _withUser(
      request,
      handler,
      authenticate: (accessToken) =>
          _authService.authenticate(accessToken: accessToken),
    );
  }

  Future<Response> withFullUser(
    Request request,
    FutureOr<Response> Function(User user) handler,
  ) {
    return _withUser(
      request,
      handler,
      authenticate: (accessToken) =>
          _authService.authenticateWithFullUser(accessToken: accessToken),
    );
  }

  Future<Response> _withUser<T>(
    Request request,
    FutureOr<Response> Function(T user) handler, {
    required Future<Result<T, AuthenticateFailure>> Function(String accessToken)
    authenticate,
  }) async {
    final token =
        request.extractBearerToken() ??
        request.cookies.valueOf(AuthCookieNames.accessToken);

    if (token == null || token.trim().isEmpty) {
      return const ServerErrorResponse(
        message:
            'The access token must be provided either in the Authorization header (Bearer) or as a cookie (for browsers).',
        code: 'TOKEN_MISSING',
      ).toJson().httpResponse(.unauthorized);
    }

    final result = await authenticate(token);

    switch (result) {
      case SuccessResult<T, AuthenticateFailure>(:final value):
        return await handler(value);

      case FailureResult<T, AuthenticateFailure>(:final failure):
        final (code, message) = switch (failure) {
          JwtValidationFailureWrapped(:final wrapped) => switch (wrapped) {
            JwtExpiredFailure() => (
              AuthErrorCodes.accessTokenExpired,
              'Access token expired',
            ),
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
              kDebugMode ? message : 'Unknown token parsing failure',
            ),
          },
          UserDeletedFailure() => (
            AuthErrorCodes.userNotFound,
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

  Future<Response> withPermission(
    Request request,
    Permission permission,
    Future<Response> Function(AuthUser user) handler,
  ) {
    return withAuthUser(request, (user) {
      if (!user.isSuperUser) {
        final permissions = user.permissions;
        if (permissions == null || !permissions.contains(permission)) {
          return ServerErrorResponse(
            message: 'You do not have permission to perform this action.',
            code: AuthErrorCodes.insufficientPermissions,
            details: {
              'permissions': permissions
                  ?.map((e) => e.toResponse().toJson())
                  .toList(),
            },
          ).toJson().httpResponse(.forbidden);
        }
      }
      return handler(user);
    });
  }
}
