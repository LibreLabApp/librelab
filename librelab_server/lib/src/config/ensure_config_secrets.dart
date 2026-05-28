import 'dart:io';

import 'package:librelab_server/src/config/config_files.dart';
import 'package:librelab_server/src/utils/utils.dart';

// https://docs.serverpod.dev/concepts/configuration#2-via-environment-variables
// https://github.com/serverpod/serverpod/blob/main/packages/serverpod_shared/lib/src/password_manager.dart#L6
const _serverpodPasswordPrefix = 'SERVERPOD_PASSWORD_';

Future<void> ensureHasConfigSecrets() async {
  if (_hasConfiguredAllSecretsViaEnv) {
    // If all required SERVERPOD_PASSWORD_* environment variables are provided,
    // assume external management and skip automatic password file generation.
    //
    // Technically, generating this file has no effect since environment
    // variables already override these values, but skipping it keeps the setup cleaner.
    //
    // Missing individual values are handled by Serverpod via clear runtime error messages.
    return;
  }

  final passwordsFile = ConfigFiles.passwords;

  if (passwordsFile.existsSync()) {
    return;
  }

  await _write(passwordsFile);
}

Future<void> _write(File passwordsFile) async {
  final parent = passwordsFile.parent;
  if (!parent.existsSync()) {
    await parent.create();
  }

  final securityMessage =
      'SECURITY: Prefer providing secrets via environment variables,\n'
      'especially in cloud deployments.\n'
      'Use this format: "$_serverpodPasswordPrefix*",\n'
      'e.g., ${_serverpodPasswordPrefix}database=... \n\n'
      'Environment variables override values in the config file ("${passwordsFile.path}").\n'
      'If all required secrets are provided via environment variables,\n'
      'this file can be removed.';

  await passwordsFile.writeAsString('''
# Note that this file should not be under version control. Store it in a safe
# place.
#
${securityMessage.split('\n').map((l) => '# $l').join('\n')}

production:
  database: '${generateSecureRandomString()}'
  serviceSecret: '${generateSecureRandomString()}'

  emailSecretHashPepper: '${generateSecureRandomString()}'
  jwtHmacSha512PrivateKey: '${generateSecureRandomString()}'
  jwtRefreshTokenHashPepper: '${generateSecureRandomString()}'
''');

  stdout.writeln(
    'Created "${passwordsFile.path}" with randomly generated secrets.\n\n'
    '$securityMessage\n',
  );

  stdout.writeln(
    'Before proceeding, verify database connection details:\n'
    ' - "${ConfigFiles.production.path}": (host, port, database name, username)\n'
    ' - "${passwordsFile.path}": (database password)\n'
    ' - Ensure the database server is reachable from this machine\n',
  );

  stdout.writeln('Press Enter to continue...');
  stdin.readLineSync();
}

final List<String> _requiredSecretKeys = List.unmodifiable([
  'database',
  'serviceSecret',
  'emailSecretHashPepper',
  'jwtHmacSha512PrivateKey',
  'jwtRefreshTokenHashPepper',
]);

bool get _hasConfiguredAllSecretsViaEnv {
  final providedEnvKeys = Platform.environment.keys.toSet();

  return _requiredSecretKeys
      .map((key) => '$_serverpodPasswordPrefix$key')
      .every(providedEnvKeys.contains);
}
