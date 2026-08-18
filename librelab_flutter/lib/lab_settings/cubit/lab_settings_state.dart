// ignore_for_file: annotate_overrides

part of 'lab_settings_cubit.dart';

@freezed
@immutable
class const LabSettingsState({
  required final FetchSettingsState fetchSettingsState,
  required final UpdateSettingsState updateSettingsState,
}) with _$LabSettingsState {
  const new initial()
    : this(
        fetchSettingsState: const .initial(),
        updateSettingsState: const .initial(),
      );

  /// Returns the lab settings if they have been loaded successfully.
  ///
  /// Throws a [StateError] if the lab settings are not available.
  LabSettings labSettingsOrThrow() {
    final state = fetchSettingsState;
    if (state is! FetchSettingsSuccess) {
      throw StateError('Login state must be successful');
    }

    return state.settings;
  }
}

@freezed
@immutable
sealed class FetchSettingsState with _$FetchSettingsState {
  const factory initial() = FetchSettingsInitial;

  const factory loading() = FetchSettingsLoading;
  const factory success(LabSettings settings) = FetchSettingsSuccess;

  const factory failure(ApiRequestFailure failure) = FetchSettingsFailure;
}

@freezed
@immutable
sealed class UpdateSettingsState with _$UpdateSettingsState {
  const factory initial() = UpdateSettingsInitial;

  const factory loading() = UpdateSettingsLoading;
  const factory success() = UpdateSettingsSuccess;

  const factory failure(ApiRequestFailure failure) = UpdateSettingsFailure;
}
