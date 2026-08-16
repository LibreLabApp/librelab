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
  AuthEndpoints get _auth => _authEndpoints;

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
          return await _auth.browser.login(
            request,
            serverBaseUrl: serverBaseUrl,
          );
        }

        return await _auth.login(request, serverBaseUrl: serverBaseUrl);
      },
      mapSuccess: (dto) {
        if (kIsWeb) {
          dto as LoginBrowserResponse;
          return LoginSuccessWithoutTokens(dto.user.toDomain());
        }

        dto as LoginResponse;
        return LoginSuccessWithTokens(
          dto.user.toDomain(),
          accessToken: dto.accessToken.toDomain(),
          refreshToken: dto.refreshToken.toDomain(),
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
  Future<ApiRequestResult<bool>> logout({required String refreshToken}) async {
    return _handler.execute(() async {
      if (kIsWeb) {
        return await _auth.browser.logout();
      }
      return await _auth.logout(.new(refreshToken: refreshToken));
    }, mapSuccess: (dto) => dto.tokenRevoked);
  }
}
