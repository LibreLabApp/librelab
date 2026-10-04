part of 'lab_settings_cubit.dart';

@immutable
@freezed
sealed class LabSettingsEffect with _$LabSettingsEffect {
  const factory resetLabImageUpdate() = ResetLabImageUpdate;
}
