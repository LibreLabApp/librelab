import 'package:librelab_server/config/secrets/app_secrets.dart';
import 'package:yaml_storage/yaml_storage.dart';

class AppSecretsRepository({
  required final String _storageId,
  required final YamlStorage _storage,
  required final Map<String, String> _platformEnvironment,
}) {
  AppSecrets? _cached;

  /// Returns `null` if the [_file] does not exist.
  Future<AppSecrets?> load() async {
    final secrets = _cached;
    if (secrets != null) {
      throw StateError('Must load the app secrets only once');
    }

    final yamlFromFile = await _storage.read(_storageId);
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
    final jwtAccessTokenSecret = _readSecret(
      AppSecrets.jwtAccessTokenSecretKey,
      fromFile: () => fileSecrets.jwtAccessTokenSecret,
    );
    final secrets = AppSecrets(
      databasePassword: databasePassword,
      jwtAccessTokenSecret: jwtAccessTokenSecret,
    );
    _cached = secrets;
    return secrets;
  }

  static const String envSecretKeyPrefix = 'SECRET_';

  static String _envKey(String key) => '$envSecretKeyPrefix$key';

  String _readSecret(String key, {required String Function() fromFile}) {
    final secret = _platformEnvironment[_envKey(key)] ?? fromFile();
    return secret;
  }

  /// File-only (by-design)
  Future<void> save(AppSecrets secrets) async {
    if (_cached != null) {
      throw StateError('Secrets cannot be modified when already loaded');
    }
    _cached = secrets;

    await _storage.write(_storageId, secrets.toYaml());
  }

  bool hasProvidedRequiredSecretsViaEnv() {
    final requiredSecretKeys = AppSecrets.requiredSecretKeys;

    final providedEnvKeys = _platformEnvironment.keys.toSet();

    return requiredSecretKeys
        .map((key) => _envKey(key))
        .every(providedEnvKeys.contains);
  }
}
