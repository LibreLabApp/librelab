import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/auth/auth_repository/auth_repository.dart';
import 'package:librelab_flutter/auth/auth_repository/login_failures.dart';
import 'package:librelab_flutter/auth/auth_repository/login_result.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_shared/result.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit({required final AuthRepository _authRepository})
    extends Cubit<LoginState> {
  this : super(const .initial());

  Future<void> login({
    required String email,
    required String password,
    required Uri serverBaseUrl,
    required bool persistAuthSession,
  }) async {
    emit(const .load());

    final requestResult = await _authRepository.login(
      email: email,
      password: password,
      serverBaseUrl: serverBaseUrl,
    );

    switch (requestResult) {
      case SuccessResult(value: final loginResult):
        switch (loginResult) {
          case LoginResultFailure(:final failure):
            emit(.failure(failure));

          case LoginResultSuccess():
            emit(.success(loginResult, persistAuthSession: persistAuthSession));
        }

      case FailureResult(:final failure):
        emit(.requestFailure(failure));
    }
  }
}
