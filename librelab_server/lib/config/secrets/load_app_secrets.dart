import 'dart:io';

import 'package:librelab_server/config/secrets/app_secrets.dart';
import 'package:librelab_server/config/secrets/app_secrets_repository.dart';
import 'package:librelab_server/utils/security/random_string.dart';

Future<AppSecrets> loadAppSecrets(
  AppSecretsRepository repository, {
  required String Function() getSecretsFilePath,
  required String Function() getConfigFilePath,
  required bool isLocalHostDatabase,
}) async {
  final appSecrets = await repository.load();

  try {
    if (appSecrets == null) {
      final defaultSecrets = AppSecrets(
        databasePassword: generateSecureRandomString(),
        jwtAccessTokenSecret: generateSecureRandomString(),
      );

      final secretsFilePath = getSecretsFilePath();
      final configFilePath = getConfigFilePath();

      stdout.writeln(
        'Created "$secretsFilePath" with randomly generated secrets.\n'
        'This file should not be under version control. It must remain in a safe place\n\n'
        'SECURITY: Prefer providing secrets via environment variables,\n'
        'especially in cloud deployments.\n'
        'Use this format: "${AppSecretsRepository.envSecretKeyPrefix}*",\n'
        'e.g., ${AppSecretsRepository.envSecretKeyPrefix}${AppSecrets.databasePasswordKey}=... \n\n'
        'Environment variables override values in the config file ("$secretsFilePath").\n',
      );

      if (!isLocalHostDatabase) {
        stdout.writeln(
          'Before proceeding, verify database connection details:\n'
          ' - "$configFilePath": (host, port, database name, username)\n'
          ' - "$secretsFilePath": (database password)\n'
          ' - Ensure the database server is reachable from this machine',
        );
      }

      stdout.writeln('Press Enter to continue...');
      stdin.readLineSync();

      await repository.save(defaultSecrets);
      return defaultSecrets;
    }

    return appSecrets;
  } finally {
    if (repository.hasProvidedRequiredSecretsViaEnv()) {
      stdout.writeln(
        'All required app secrets were provided via environment variables',
      );
    }
  }
}
