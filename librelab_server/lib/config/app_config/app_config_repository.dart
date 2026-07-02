import 'package:librelab_server/config/app_config/app_config.dart';
import 'package:yaml_storage/yaml_storage.dart';

class AppConfigRepository({
  required final String _storageId,
  required final YamlStorage _storage,
}) {
  AppConfig? _cached;
  AppConfig get cached =>
      _cached ?? (throw StateError('$AppConfig must not be null'));

  Future<AppConfig?> load() async {
    final config = _cached;
    if (config != null) {
      throw StateError('Must load the app config only once');
    }

    final root = await _storage.read(_storageId);
    if (root == null) {
      return null;
    }
    return _cached = AppConfig.fromYaml(root);
  }

  Future<void> save(AppConfig config) async {
    _cached = config;
    await _storage.write(_storageId, config.toYaml());
  }

  Future<void> update({SetupPromptDeclinedConfig? setupPromptDeclined}) async {
    var newConfig = cached;
    if (setupPromptDeclined != null) {
      newConfig = newConfig.copyWith(setupPromptDeclined: setupPromptDeclined);
    }
    await save(newConfig);
  }
}
