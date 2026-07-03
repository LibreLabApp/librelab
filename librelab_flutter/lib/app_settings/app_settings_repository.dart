import 'package:json_storage/json_storage.dart';
import 'package:librelab_flutter/app_settings/app_settings.dart';

class AppSettingsRepository(
  final JsonStorage _storage,
  final String _storageId,
) {
  AppSettings? _cached;
  AppSettings get cached =>
      _cached ?? (throw StateError('Settings must be loaded'));

  Future<AppSettings> load() async {
    final cachedSettings = _cached;
    if (cachedSettings != null) {
      return cachedSettings;
    }
    final json = await _storage.read(_storageId);
    return _cached = .fromJsonWithDefaults(json);
  }

  Future<void> save(AppSettings updated) async {
    await _storage.write(_storageId, updated.toJson());
    _cached = updated;
  }
}
