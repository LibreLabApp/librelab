import 'package:librelab_server/config/app_config/app_config.dart';
import 'package:yaml_storage/yaml_storage.dart';

class AppConfigRepository({
  required final String _storageId,
  required final YamlStorage _storage,
}) {
  AppConfig? _config;

  AppConfig? get config => _config;
  AppConfig get configOrThrow =>
      config ?? (throw StateError('$AppConfig must not be null'));

  Future<AppConfig?> load() async {
    final config = _config;
    if (config != null) {
      throw StateError('Must load the app config only once');
    }

    final root = await _storage.read(_storageId);
    if (root == null) {
      return null;
    }
    return _config = AppConfig.fromYaml(root);
  }

  Future<void> save(AppConfig config) async {
    _config = config;

    await _storage.write(_storageId, config.toYaml());
  }

  Future<void> update({SetupPromptDeclinedConfig? setupPromptDeclined}) async {
    var newConfig = configOrThrow;
    if (setupPromptDeclined != null) {
      newConfig = newConfig.copyWith(setupPromptDeclined: setupPromptDeclined);
    }
    await save(newConfig);
  }
}
