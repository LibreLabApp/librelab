part of 'login_cubit.dart';

@immutable
@freezed
sealed class LoginState with _$LoginState {
  const factory initial() = Initial;

  const factory load() = Load;
  const factory success(
    LoginResultSuccess result, {
    required bool persistAuthSession,
  }) = Success;

  const factory failure(LoginFailure failure) = Failure;
  const factory requestFailure(ApiRequestFailure failure) = RequestFailure;
}

extension LoginStateExt on LoginState {
  bool get isLoading => this is Load;

  /// Whether the login operation completed successfully.
  ///
  /// This only represents the outcome of the login operation and does not
  /// indicate whether the authentication session is persisted.
  bool get isSuccess => this is Success;
}
