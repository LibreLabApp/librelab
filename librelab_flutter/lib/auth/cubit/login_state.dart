part of 'login_cubit.dart';

@freezed
@immutable
sealed class LoginState with _$LoginState {
  const factory initial() = Initial;

  const factory loading() = Loading;
  const factory success(
    LoginResultSuccess result, {
    required bool persistAuthSession,
  }) = Success;

  const factory failure(LoginFailure failure) = Failure;
  const factory requestFailure(ApiRequestFailure failure) = RequestFailure;
}

extension LoginStateExt on LoginState {
  bool get isLoading => this is Loading;

  /// Whether the login operation completed successfully.
  ///
  /// This only represents the outcome of the login operation and does not
  /// indicate whether the authentication session is persisted.
  bool get isSuccess => this is Success;

  bool get isRequestFailure => this is RequestFailure;

  /// Requires this state to be successful and returns its [LoginResultSuccess].
  ///
  /// Throws a [StateError] if this state is not successful.
  LoginResultSuccess successOrThrow() {
    final state = this;
    if (state is! Success) {
      throw StateError('Login state must be successful');
    }

    return state.result;
  }
}
