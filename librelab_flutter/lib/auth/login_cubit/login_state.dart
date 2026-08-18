part of 'login_cubit.dart';

@freezed
@immutable
sealed class LoginState with _$LoginState {
  const factory initial() = Initial;

  /// Indicates that a login or logout operation is in progress.
  const factory loading() = Loading;

  /// Indicates that the login operation completed successfully.
  ///
  /// [persistAuthSession] specifies whether the authentication session should
  /// be persisted.
  const factory success(
    LoginResultSuccess result, {
    required bool persistAuthSession,
  }) = Success;

  /// Indicates that the login operation failed due to invalid login credentials
  /// or another login-specific failure.
  const factory failure(LoginFailure failure) = Failure;

  /// Indicates that the login or logout request failed.
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

  /// Returns this state if the login operation completed successfully.
  ///
  /// Throws a [StateError] if the login operation did not complete successfully.
  Success successOrThrow() {
    final state = this;
    if (state is! Success) {
      throw StateError('Login state must be successful');
    }

    return state;
  }
}
