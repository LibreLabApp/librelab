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
