import 'dart:io';

import 'package:librelab_server/config/secrets/app_secrets.dart';
import 'package:librelab_server/utils/file_storage/yaml_file_storage.dart';

class AppSecretsRepository {
  AppSecretsRepository({
    required this._file,
    required this._fileStorage,
    required this._platformEnvironment,
  });

  final File _file;
  final YamlFileStorage _fileStorage;
  final Map<String, String> _platformEnvironment;

  AppSecrets? _secrets;

  AppSecrets? get secrets => _secrets;
  AppSecrets get secretsOrThrow =>
      secrets ?? (throw StateError('$AppSecrets must not be null'));

  /// Returns `null` if the [_file] does not exist.
  Future<AppSecrets?> load() async {
    final secrets = _secrets;
    if (secrets != null) {
      throw StateError('Must load the app secrets only once');
    }

    final yamlFromFile = await _fileStorage.read(_file);
    if (yamlFromFile == null) {
      return null;
    }
    return _resolve(AppSecrets.fromYaml(yamlFromFile));
  }

  AppSecrets _resolve(AppSecrets fileSecrets) {
    final databasePassword = _readSecret(
      AppSecrets.databasePasswordKey,
      fromFile: () => fileSecrets.databasePassword,
    );
    final secrets = AppSecrets(databasePassword: databasePassword);
    _secrets = secrets;
    return secrets;
  }

  static const String envSecretKeyPrefix = 'SECRET_';

  String _readSecret(String key, {required String Function() fromFile}) {
    final secret =
        _platformEnvironment['$envSecretKeyPrefix$key'] ?? fromFile();
    return secret;
  }

  // File-only (by-design)
  Future<void> save(AppSecrets secrets) async {
    if (_secrets != null) {
      throw StateError('Secrets cannot be modified when already loaded');
    }
    _secrets = secrets;

    await _fileStorage.write(_file, secrets.toYaml());
  }

  bool hasProvidedRequiredSecretsViaEnv() {
    final requiredSecretKeys = AppSecrets.requiredSecretKeys;

    final providedEnvKeys = _platformEnvironment.keys.toSet();

    return requiredSecretKeys
        .map((key) => '$envSecretKeyPrefix$key')
        .every(providedEnvKeys.contains);
  }
}
