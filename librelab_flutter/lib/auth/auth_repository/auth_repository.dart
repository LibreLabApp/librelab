import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_flutter/auth/auth_repository/login_failures.dart';
import 'package:librelab_flutter/auth/auth_repository/login_result.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:librelab_flutter/user/user_dto_mappers.dart';

/// Performs authentication operations against the server.
/// Does not manage persistence or in-memory authentication state.
class AuthRepository({
  required final AuthEndpoints _authEndpoints,
  required final ApiRequestHandler _handler,
}) {
  AuthEndpoints get _endpoints => _authEndpoints;

  Future<ApiRequestResult<LoginResult>> login({
    required String email,
    required String password,
    required Uri serverBaseUrl,
  }) async {
    final request = LoginRequest(
      email: email,
      password: password,
      // TODO: (AUTH) Either pass a correct non-null value, or remove deviceId completely from the system
      deviceId: null,
    );

    return await _handler.execute(
      () async {
        if (kIsWeb) {
          return await _endpoints.browser.login(
            request,
            serverBaseUrl: serverBaseUrl,
          );
        }

        return await _endpoints.login(request, serverBaseUrl: serverBaseUrl);
      },
      mapSuccess: (dto) {
        if (dto is LoginBrowserResponse) {
          return LoginResultSuccess(
            user: dto.user.toDomain(),
            authSession: .browserCookie(userId: dto.user.id),
          );
        }

        if (dto is LoginResponse) {
          return LoginResultSuccess(
            user: dto.user.toDomain(),
            authSession: .memory(
              userId: dto.user.id,
              accessToken: dto.accessToken,
              refreshToken: dto.refreshToken,
            ),
          );
        }

        throw StateError(
          'Response must be either LoginBrowserResponse or LoginResponse.',
        );
      },
      mapHttpError: (response) {
        final code = response.body.code;
        if (code == AuthErrorCodes.invalidLoginCredentials) {
          return const LoginResultFailure(InvalidLoginCredentialsFailure());
        }
        if (code == AuthErrorCodes.loginDisabled) {
          return const LoginResultFailure(LoginDisabledFailure());
        }
        if (code == AuthErrorCodes.invalidLoginCredentials) {
          return const LoginResultFailure(InvalidLoginInputFailure());
        }
        return null;
      },
    );
  }

  /// Returns whether the refresh token was found and revoked.
  Future<ApiRequestResult<bool>> logout({required String? refreshToken}) async {
    return _handler.execute(() async {
      if (kIsWeb) {
        return await _endpoints.browser.logout();
      }
      if (refreshToken == null) {
        throw ArgumentError(
          'refreshToken must not be null on non-web platforms.',
        );
      }
      return await _endpoints.logout(.new(refreshToken: refreshToken));
    }, mapSuccess: (dto) => dto.tokenRevoked);
  }
}
