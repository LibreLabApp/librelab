import 'package:librelab_server/lab_settings/lab_settings.dart';

/// Backed by a single persistent row.
abstract interface class LabSettingsRepository {
  /// Creates or updates the persisted settings.
  ///
  /// Returns the resulting [LabSettings] after applying [patch].
  /// Also updates the in-memory cached value.
  Future<LabSettings> update(LabSettingsPatch patch);

  /// Loads the settings from persistence.
  ///
  /// Returns the stored [LabSettings] if available.
  /// Returns `null` if no settings have been stored yet.
  ///
  /// Does not update in-memory cache when the result is `null`.
  Future<LabSettings?> load();

  /// In-memory cached settings.
  ///
  /// Initialized only when [load] returns non-null or after [update].
  /// Throws [StateError] if accessed before initialization.
  LabSettings get cached;
}
