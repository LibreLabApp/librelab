import 'package:librelab_server/settings/app_settings.dart';
import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

abstract interface class AppSettingsRepository {
  /// Creates or updates the persisted application settings.
  ///
  /// Returns the resulting [AppSettings] after applying [patch].
  /// Also updates the in-memory cached value.
  Future<AppSettings> upsert(AppSettingsPatch patch);

  /// Loads the settings from persistence.
  ///
  /// Returns the stored [AppSettings] if available.
  /// Returns `null` if no settings have been stored yet.
  ///
  /// Does not update in-memory cache when the result is `null`.
  Future<AppSettings?> load();

  /// In-memory cached settings.
  ///
  /// Initialized only when [load] returns non-null or after [upsert].
  /// Throws [StateError] if accessed before initialization.
  AppSettings get cached;
}

@immutable
class AppSettingsPatch {
  const AppSettingsPatch({
    this.labName = const .absent(),
    this.loginDisabled = const .absent(),
  });

  final Field<String?> labName;
  final Field<bool> loginDisabled;
}
