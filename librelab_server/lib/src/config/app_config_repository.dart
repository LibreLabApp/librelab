import 'dart:io' show File;

import 'package:librelab_server/src/config/app_config/app_config.dart';
import 'package:librelab_server/src/utils/file_storage/yaml_file_storage.dart';

class AppConfigRepository {
  AppConfigRepository({required this._fileStorage, required this._file});

  final File _file;
  final YamlFileStorage _fileStorage;

  AppConfig? _config;

  AppConfig? get config => _config;
  AppConfig get configOrThrow =>
      config ?? (throw StateError('$AppConfig must not be null'));

  Future<AppConfig?> load() async {
    final config = _config;
    if (config != null) {
      throw StateError('Must load the app config only once');
    }

    final root = await _fileStorage.read(_file);
    if (root == null) {
      return null;
    }
    return _config = AppConfig.fromYaml(root);
  }

  Future<void> save(AppConfig config) async {
    _config = config;

    await _fileStorage.write(_file, config.toYaml());
  }

  Future<void> update({SetupPromptDeclinedConfig? setupPromptDeclined}) async {
    var newConfig = configOrThrow;
    if (setupPromptDeclined != null) {
      newConfig = newConfig.copyWith(setupPromptDeclined: setupPromptDeclined);
    }
    await save(newConfig);
  }
}
