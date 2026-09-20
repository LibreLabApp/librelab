part of 'login_identity_cubit.dart';

@freezed
@immutable
class const LoginIdentityState({
  required final LoadLoginIdentitiesState loadState,
  required final LogoutState logoutState,
}) with _$LoginIdentityState {
  const new initial()
    : this(loadState: const .initial(), logoutState: const .initial());
}

@freezed
@immutable
sealed class LoadLoginIdentitiesState with _$LoadLoginIdentitiesState {
  const factory initial() = LoadLoginIdentitiesInitial;

  const factory loading() = LoadLoginIdentitiesLoading;
  const factory success({
    required LoginIdentities loginIdentities,

    /// The login identity and server currently selected by the application.
    ///
    /// `null` when no login identity is selected.
    required SelectedLoginIdentity? selectedLoginIdentity,
  }) = LoadLoginIdentitiesSuccess;

  /// A failure that preserves the original exception for technical error details.
  ///
  /// The UI presents a user-friendly, localized failure message while exposing
  /// [exception.toString()] through the error tooltip for debugging and error
  /// reporting.
  const factory failure(Exception exception) = LoadLoginIdentitiesFailure;
}

@freezed
@immutable
sealed class LogoutState with _$LogoutState {
  const factory initial() = LogoutInitial;

  const factory loading() = LogoutLoading;
  const factory success() = LogoutSuccess;

  const factory failure(ApiRequestFailure failure) = LogoutFailure;
}

@freezed
@immutable
class const SelectedLoginIdentity({
  required final LoginIdentity loginIdentity,
  required final Server server,
}) with _$SelectedLoginIdentity;

extension LoadLoginIdentitiesStateExt on LoadLoginIdentitiesState {
  bool get isLoading => this is LoadLoginIdentitiesLoading;
  String? get failureOrNull => switch (this) {
    LoadLoginIdentitiesFailure(:final exception) => exception.toString(),
    _ => null,
  };
}

extension LogoutStateExt on LogoutState {
  bool get isLoading => this is LogoutLoading;
}
