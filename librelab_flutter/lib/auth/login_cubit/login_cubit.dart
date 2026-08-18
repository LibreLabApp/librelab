import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/auth/auth_repository/auth_repository.dart';
import 'package:librelab_flutter/auth/auth_repository/login_failures.dart';
import 'package:librelab_flutter/auth/auth_repository/login_result.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_shared/result.dart';
import 'package:logging/logging.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

/// Manages a temporary login session that is not persisted locally.
/// Used as part of a larger flow where the authenticated identity is
/// persisted separately after the flow is completed.
class LoginCubit({
  required final AuthRepository _authRepository,
  required final LibreLabApiClient _client,
  required final Logger _logger,
}) extends Cubit<LoginState> {
  this : super(const .initial());

  Future<void> login({
    required String email,
    required String password,
    required Uri serverBaseUrl,
    required bool persistAuthSession,
  }) async {
    emit(const .loading());

    final result = await _authRepository.login(
      email: email,
      password: password,
      serverBaseUrl: serverBaseUrl,
    );

    switch (result) {
      case SuccessResult(value: final loginResult):
        switch (loginResult) {
          case LoginResultFailure(:final failure):
            emit(.failure(failure));

          case LoginResultSuccess():
            // Important: this side effect updates the client with the server to connect
            // to and the user's authentication session for subsequent authenticated
            // requests. It must be reverted if the login flow is abandoned before
            // completion, such as when adding a non-first account.
            _client.setBaseUrl(serverBaseUrl);
            _client.setAuthSession(loginResult.authSession);

            emit(.success(loginResult, persistAuthSession: persistAuthSession));
        }

      case FailureResult(:final failure):
        emit(.requestFailure(failure));
    }
  }

  Future<void> logout() async {
    final state = this.state;

    if (state is! Success) {
      throw StateError('Cannot logout when not logged in.');
    }

    emit(const .loading());

    final result = await _authRepository.logout(
      refreshToken: switch (state.result.authSession) {
        AuthSessionMemory(:final refreshToken) => refreshToken.value,
        AuthSessionBrowserCookie() => null,
      },
    );

    switch (result) {
      case SuccessResult(value: final tokenRevoked):
        _logger.info(
          'Successfully logged out user ${state.result.user.id}: '
          '${tokenRevoked ? 'refresh token was found and revoked.' : 'refresh token was not found.'}',
        );

        _client.setAuthSession(null);

        emit(const .initial());

      case FailureResult(:final failure):
        emit(.requestFailure(failure));
    }
  }
}
