import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:librelab_server/src/config/config_files.dart';

/// Generates a secure random string of the specified length.
///
/// The [byteLength] parameter specifies the number of random bytes to generate.
/// The result is base64url-encoded without padding.
// For consistency with Serverpod, this was copied from: https://github.com/serverpod/serverpod/blob/5affa49285249267d315a6d36148f7608b6eb626/modules/serverpod_auth/serverpod_auth_idp/serverpod_auth_idp_flutter/lib/src/common/utils.dart#L4-L12
String _generateSecureRandomString([int byteLength = 24]) {
  final random = Random.secure();
  final bytes = List<int>.generate(byteLength, (i) => random.nextInt(256));
  return base64UrlEncode(bytes).replaceAll('=', '');
}

// https://docs.serverpod.dev/concepts/configuration#2-via-environment-variables
const _serverpodPasswordPrefix = 'SERVERPOD_PASSWORD_';

Future<void> ensureHasConfigSecrets() async {
  final passwordsFoundInEnv = Platform.environment.entries
      .where((e) => e.key.startsWith(_serverpodPasswordPrefix))
      .isNotEmpty;
  if (passwordsFoundInEnv) {
    // If any SERVERPOD_PASSWORD_* environment variable is present, assume external management
    // and skip automatic password file generation.
    //
    // If none are present and no config file exists, it generates a default file for local setup.
    // Missing individual values are handled by Serverpod via clear runtime error messages.
    return;
  }

  final passwordsFile = ConfigFiles.passwords;
  await passwordsFile.parent.create();

  if (passwordsFile.existsSync()) {
    return;
  }

  final securityMessage =
      'SECURITY: Prefer providing secrets via environment variables,\n'
      'especially in cloud deployments.\n'
      'Use this format: "SERVERPOD_PASSWORD_*",\n'
      'e.g., SERVERPOD_PASSWORD_database=... \n\n'
      'Environment variables override values in the config file ("${passwordsFile.path}").\n'
      'If all required secrets are provided via environment variables,\n'
      'this file can be removed.';

  await passwordsFile.writeAsString('''
# Note that this file should not be under version control. Store it in a safe
# place.
#
${securityMessage.split('\n').map((l) => '# $l').join('\n')}

production:
  database: '${_generateSecureRandomString()}'
  serviceSecret: '${_generateSecureRandomString()}'

  emailSecretHashPepper: '${_generateSecureRandomString()}'
  jwtHmacSha512PrivateKey: '${_generateSecureRandomString()}'
  jwtRefreshTokenHashPepper: '${_generateSecureRandomString()}'
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
