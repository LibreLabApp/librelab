part of 'login_identity_cubit.dart';

@immutable
@freezed
sealed class LoginIdentityEffect with _$LoginIdentityEffect {
  /// Indicates that explicit confirmation is required before logging out.
  ///
  /// [isLoginDisabled] indicates whether login is currently disabled, allowing
  /// the UI to present an appropriate warning.
  const factory confirmationRequired({required bool isLoginDisabled}) =
      LogoutConfirmationRequired;

  /// Indicates that displaying a failure message is required for a failed
  /// logout request.
  const factory logoutFailureMessage(ApiRequestFailure failure) =
      LogoutFailureMessage;
}
