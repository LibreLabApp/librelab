import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/auth/auth_repository/auth_repository.dart';
import 'package:librelab_flutter/auth/auth_repository/login_failures.dart';
import 'package:librelab_flutter/auth/auth_repository/login_result.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_shared/result.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit({
  required final AuthRepository _authRepository,
  required final LibreLabApiClient _client,
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
            _client.setAuthSession(loginResult.session);

            emit(.success(loginResult, persistAuthSession: persistAuthSession));
        }

      case FailureResult(:final failure):
        emit(.requestFailure(failure));
    }
  }

  // TODO: Implement logout inside the login step
  //  Emit result properly (progress indicator, failure) instead of this:
  Future<void> logout() async {
    final state = this.state;

    if (state is! Success) {
      throw StateError('Cannot logout when not logged in.');
    }

    _client.setAuthSession(null);
    _client.setBaseUrl(null);

    emit(const .initial());

    await _authRepository.logout(
      refreshToken: switch (state.result.session) {
        AuthSessionMemory(:final refreshToken) => refreshToken.value,
        AuthSessionBrowserCookie() => null,
      },
    );
  }
}
