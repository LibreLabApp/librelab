import 'dart:io';

import 'package:librelab_server/src/config/config_files.dart';
import 'package:librelab_server/src/constants/constants.dart';
import 'package:librelab_server/src/postgres_installer/platforms/linux.dart';
import 'package:librelab_server/src/postgres_installer/platforms/windows.dart';
import 'package:librelab_server/src/postgres_installer/postgres_platform_installer.dart';
import 'package:librelab_server/src/postgres_installer/postgres_version_constants.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:librelab_server/src/utils/cli_input.dart';
import 'package:librelab_server/src/utils/cpu_architecture.dart';
import 'package:librelab_server/src/utils/linux/linux_os_release.dart';
import 'package:librelab_server/src/utils/platform_check.dart';
import 'package:librelab_server/src/utils/shutdown.dart';
import 'package:librelab_server/src/utils/utils.dart';

/// Prompts the user to install PostgreSQL if not already installed
/// and supported on the current OS, unless the user previously declined.
///
/// During installation, a temporary random PostgreSQL superuser password
/// is generated automatically.
///
/// After setup, a new PostgreSQL role named [appUser] is created with
/// the password [appPassword], and a database named [appDatabaseName]
/// owned by [appUser] is created.
Future<void> tryInstallPostgresWithPrompt({
  required String appUser,
  required String appPassword,
  required String appDatabaseName,
  required void Function() onDeclined,
}) async {
  if (await _isPostgresLikelyAvailable()) {
    return;
  }

  final PostgresPlatformInstaller? platformInstaller =
      await _resolvePlatformInstaller();
  final supportsAutomatedInstall = platformInstaller != null;

  if (!supportsAutomatedInstall) {
    stdout.writeln(
      'Automatic PostgreSQL database installation is not supported by the program on this system.',
    );
    return;
  }

  final hasPostgresInDocker =
      await _isDockerCliAvailable() &&
      await _isPostgresDockerContainerPresent();

  final userApproved = _promptPostgresInstall(
    hasPostgresInDocker: hasPostgresInDocker,
  );
  if (!userApproved) {
    stdout.writeln(
      '\nPostgreSQL auto-installer is disabled. This choice will not be prompted again.\n'
      'To change this setting later, edit: ${ConfigFiles.forCurrentRunMode().path}\n',
    );
    onDeclined();
    return;
  }

  final versionInfo = _promptPostgresVersion();

  String? tempSuperPassword;

  switch (platformInstaller) {
    case PostgresPlatformPackageManagerInstaller():
      tempSuperPassword = null;
      await platformInstaller.performInstall(versionInfo: versionInfo);

    case PostgresPlatformFileInstaller():

      // The super password is not stored anywhere outside of memory (for security reasons).
      // Users will have to either temporarily edit "pg_hba.conf" rules
      // or re-install PostgreSQL to reset it. Typically the target audience of this project
      // don't need admin access to PostgreSQL.
      //
      // Technically, the macOS version supports setting the superpassword
      // during the installation, but this approach is still only used on Windows.
      tempSuperPassword = generateSecureRandomString();

      await platformInstaller.performInstall(
        superPassword: tempSuperPassword,
        versionInfo: versionInfo,
      );
  }

  await _createAppUser(
    appUser: appUser,
    appPassword: appPassword,
    superPassword: tempSuperPassword,
    postgresVersionInfo: versionInfo,
  );

  await _createAppDb(
    appDatabaseName,
    ownedBy: appUser,
    superPassword: tempSuperPassword,
    postgresVersionInfo: versionInfo,
  );
}

PostgresVersionInfo _promptPostgresVersion() {
  final defaultVersion = PostgresVersionInfo.recommended;
  const availableVersions = PostgresVersionInfo.values;

  final availableVersionNumbers = availableVersions.map((e) => e.majorVersion);

  final input = promptInput(
    'Select PostgreSQL version (${availableVersionNumbers.join(', ')}) [Default: ${defaultVersion.majorVersion}]: ',
    allowEmpty: true,
    validateInput: (input) {
      return availableVersionNumbers.contains(input)
          ? null
          : 'Invalid PostgreSQL version. Available versions: $availableVersionNumbers';
    },
  );

  if (input.isEmpty) {
    return defaultVersion;
  }

  return PostgresVersionInfo.fromMajorVersion(input);
}

/// Runs SQL [command] command using `psql`.
///
/// Unix (Linux/macOS, [superPassword] is irrelevant, must be `null`):
///
/// sudo -u postgres psql -c [command]
///
/// Others (Windows, [superPassword] is required to set PGPASSWORD):
///
/// psql -U postgres -c [command]
///
/// Note: Technically, the second command can be run on Unix OSs,
/// but depending on the default `pg_hba.conf` rules (differ from distro/package manager to another),
/// it may not work, or requires some workarounds.
///
/// For example, with Ubuntu/Apt default installation, it requires forcing
/// TCP by passing `-h 127.0.0.1` to avoid peer authentication.
///
/// With Fedora/Dnf default installation, the TCP approach does not work
/// and will require modifying `pg_hba.conf` rules (https://stackoverflow.com/questions/50098688/postgresql-ident-authentication-failed-on-fedora).
Future<ProcessResult> _executeSql({
  required String command,
  required String? superPassword,
  required String Function(String humanReadableCommand) onLogBeforeExecuting,
  required PostgresVersionInfo postgresVersionInfo,
}) async {
  final isSudo = isUnixLike;

  if (isSudo && superPassword != null) {
    throw ArgumentError('superPassword must be null on Unix OSs');
  }

  final psqlExecutable = isWindows
      ? WindowsPostgresInstaller.binExePath(
          'psql',
          postgresMajorVersion: postgresVersionInfo.majorVersion,
        )
      : 'psql';

  final executable = isSudo ? 'sudo' : psqlExecutable;

  final args = _buildPsqlArgs(
    isSudo: isSudo,
    psqlExecutable: psqlExecutable,
    sqlCommand: command,
  );

  final environment = isSudo
      ? null
      : {
          'PGPASSWORD':
              superPassword ??
              (throw ArgumentError.value(
                null,
                'superPassword',
                'must not be null on non-Unix OSs',
              )),
        };

  stdout.writeln(
    onLogBeforeExecuting(
      buildHumanReadableCommand(executable: executable, args: args),
    ),
  );

  final result = await Process.run(executable, args, environment: environment);

  return result;
}

List<String> _buildPsqlArgs({
  required String sqlCommand,
  required bool isSudo,
  required String psqlExecutable,
}) {
  if (isSudo) {
    return [
      '-u',
      PostgresConstants.defaultOsUser,
      psqlExecutable,
      '-c',
      sqlCommand,
    ];
  }

  return ['-U', PostgresConstants.defaultDbUser, '-c', sqlCommand];
}

Future<void> _createAppUser({
  required String appUser,
  required String appPassword,
  required String? superPassword,
  required PostgresVersionInfo postgresVersionInfo,
}) async {
  try {
    final result = await _executeSql(
      command: "CREATE USER $appUser WITH PASSWORD '$appPassword';",
      superPassword: superPassword,
      onLogBeforeExecuting: (humanReadableCommand) {
        final regex = RegExp(r"WITH PASSWORD\s+'([^']*)'");

        final censoredCommand = humanReadableCommand.replaceAllMapped(
          regex,
          (match) => "WITH PASSWORD '****'",
        );
        return 'Running "$censoredCommand" (CENSORED) to create the app user.';
      },
      postgresVersionInfo: postgresVersionInfo,
    );

    if (result.exitCode == 0) {
      stdout.writeln('User "$appUser" created successfully.');
      return;
    }

    final error = result.stderr.toString();

    // Might not be detected if PostgreSQL locale is not en
    if (error.contains('already exists')) {
      stdout.writeln('User "$appUser" already exists.');
      return;
    }

    stderr.writeln(
      'Failed to create user "$appUser". Exit code: ${result.exitCode}\n'
      'PostgreSQL error output: $error',
    );
  } on Exception catch (e) {
    stderr.writeln('Failed to create "$appUser" user: $e');
  }

  await shutdown(isSuccess: false);
  throw shutdownInvariantError;
}

Future<void> _createAppDb(
  String appDatabase, {
  required String ownedBy,
  required String? superPassword,
  required PostgresVersionInfo postgresVersionInfo,
}) async {
  try {
    final result = await _executeSql(
      command: 'CREATE DATABASE $appDatabase OWNER $ownedBy;',
      superPassword: superPassword,
      onLogBeforeExecuting: (humanReadableCommand) {
        return 'Running "$humanReadableCommand" to create the app database.';
      },
      postgresVersionInfo: postgresVersionInfo,
    );

    if (result.exitCode == 0) {
      stdout.writeln('Database "$appDatabase" created successfully.');
      return;
    }

    final error = result.stderr.toString();

    // Might not be detected if PostgreSQL locale is not en
    if (error.contains('already exists')) {
      stdout.writeln('Database "$appDatabase" already exists.');
      return;
    }

    stderr.writeln(
      'Failed to create database "$appDatabase". Exit code: ${result.exitCode}\n'
      'PostgreSQL error output: $error',
    );
  } on Exception catch (e) {
    stderr.writeln('Failed to create "$appDatabase" user: $e');
  }

  await shutdown(isSuccess: false);
  throw shutdownInvariantError;
}

bool _promptPostgresInstall({required bool hasPostgresInDocker}) {
  const dockerMessage =
      '\n\nNote: A Docker container that appears to contain PostgreSQL was detected.\n'
      'You can reject the system installation and instead manually configure the connection\n'
      'to use the PostgreSQL instance running inside Docker (host, port, db, username, and password).';

  const unixMessage = '''
\n\nThis will use your system package manager to automate the process,
and will run "sudo" commands, which may require password authentication.''';

  stdout.writeln('''
\nPostgreSQL was not detected on the system.${hasPostgresInDocker ? dockerMessage : ''}

Automated installation and initial configuration can be performed,
including download, setup, and adding the installation to the user PATH.${isUnixLike ? unixMessage : ''}
''');
  return promptYesNo(
    'Proceed with automated PostgreSQL installation and configuration?',
    defaultValue: true,
  );
}

Future<PostgresPlatformInstaller?> _resolvePlatformInstaller() async {
  return switch (currentDesktopPlatform) {
    DesktopPlatform.linux => await () async {
      final packageManager =
          await LinuxPostgresInstaller.systemPackageManager();
      if (packageManager != null) {
        return LinuxPostgresInstaller(
          packageManager: packageManager,
          linuxOsRelease: LinuxOsRelease(),
        );
      }
      return null;
    }(),
    DesktopPlatform.macOS => null,
    DesktopPlatform.windows =>
      // Windows x86-32 is no longer supported
      (isWindowsX64()) ? WindowsPostgresInstaller() : null,
  };
}

Future<bool> _isPostgresLikelyAvailable() async {
  if (await _isPostgresCliAvailable()) {
    return true;
  }
  if (isWindows) {
    final postgresDir =
        WindowsPostgresInstaller.windowsRegistryPostgresInstallDir();
    if (postgresDir != null) {
      stdout.writeln(
        'PostgreSQL installation detected via Windows registry at: $postgresDir\n'
        'PostgreSQL executables (${_pathExecutables.join(', ')}) are not currently accessible from PATH or expected bin directories!\n'
        'Is this installation corrupted, or is the server restricted?\n'
        'This may happen if the PostgreSQL files were removed without using the uninstaller.',
      );
      return true;
    }
  }

  return false;
}

Future<bool> _isDockerCliAvailable() async {
  try {
    final result = await Process.run('docker', ['--version']);
    return result.exitCode == 0;
  } on Exception catch (_) {
    return false;
  }
}

Future<bool> _isPostgresDockerContainerPresent() async {
  final result = await Process.run('docker', [
    'ps',
    '-a',
    '--format',
    '{{.Names}}',
  ]);

  if (result.exitCode != 0) {
    return false;
  }

  final output = result.stdout.toString();
  return output.split('\n').any((name) => name.trim() == 'postgres');
}

final List<String> _pathExecutables = List.unmodifiable(['psql', 'postgres']);

Future<bool> _isPostgresCliAvailable() async {
  try {
    // Windows-only: Adds the same executables, but with the absolute path
    // in case they were not added to the user PATH.
    // This is unnecessary on Linux/macOS since typically the package manager
    // handles the addition.
    final absoluteExecutables = isWindows
        ? _pathExecutables
              .expand(
                (executable) => PostgresVersionInfo.values.map(
                  (version) => WindowsPostgresInstaller.binExePath(
                    executable,
                    postgresMajorVersion: version.majorVersion,
                  ),
                ),
              )
              .toList()
        : <String>[];

    final List<String> executables = List.unmodifiable([
      ..._pathExecutables,
      ...absoluteExecutables,
    ]);

    for (final executable in executables) {
      final result = await Process.run(executable, ['--version']);
      final available =
          result.exitCode == 0 && result.stdout.toString().trim().isNotEmpty;
      if (available) {
        return true;
      }
    }
    return false;
  } on Exception catch (_) {
    return false;
  }
}
