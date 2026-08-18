// ignore_for_file: annotate_overrides

part of 'login_identity_cubit.dart';

@freezed
@immutable
sealed class LoginIdentityState with _$LoginIdentityState {
  const factory initial() = Initial;

  const factory loading() = Loading;
  const factory success({
    required LoginIdentities loginIdentities,

    /// The login identity and server currently selected by the application.
    ///
    /// `null` when no login identity is selected.
    required SelectedLoginIdentity? selectedLoginIdentity,
  }) = Success;

  /// A failure that preserves the original exception for technical error details.
  ///
  /// The UI presents a user-friendly, localized failure message while exposing
  /// [exception.toString()] through the error tooltip for debugging and error
  /// reporting.
  const factory failure(Exception exception) = Failure;
}

@freezed
@immutable
class const SelectedLoginIdentity({
  required final LoginIdentity loginIdentity,
  required final Server server,
}) with _$SelectedLoginIdentity;

extension LoginIdentityStateExt on LoginIdentityState {
  bool get isLoading => this is Loading;
  String? get failureOrNull => switch (this) {
    Failure(:final exception) => exception.toString(),
    _ => null,
  };
}
