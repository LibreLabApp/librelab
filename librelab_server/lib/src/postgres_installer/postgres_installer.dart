import 'dart:io';

import 'package:librelab_server/src/config/config_files.dart';
import 'package:librelab_server/src/postgres_installer/platforms/linux.dart';
import 'package:librelab_server/src/postgres_installer/platforms/windows.dart';
import 'package:librelab_server/src/postgres_installer/postgres_platform_installer.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:librelab_server/src/utils/cli_input.dart';
import 'package:librelab_server/src/utils/cpu_architecture.dart';
import 'package:librelab_server/src/utils/platform_check.dart';
import 'package:librelab_server/src/utils/shutdown.dart';
import 'package:librelab_shared/librelab_shared.dart';

Future<void> tryInstallPostgresWithPrompt({
  required String superPassword,
  required String databaseName,
  required void Function() onDeclined,
}) async {
  final PostgresPlatformInstaller? platformInstaller =
      await _getPlatformInstaller();
  final supportsAutomatedInstall = platformInstaller != null;

  if (!supportsAutomatedInstall) {
    stdout.writeln(
      'Automatic PostgreSQL database installation is not supported by the program on this system.',
    );
    return;
  }

  if (await _isPostgresLikelyAvailable()) {
    return;
  }

  final hasPostgresInDocker =
      await _isDockerCliAvailable() &&
      await _isPostgresDockerContainerPresent();
  if (!_promptPostgresInstall(hasPostgresInDocker: hasPostgresInDocker)) {
    stdout.writeln(
      '\nPostgreSQL auto-installer is disabled. This choice will not be prompted again.\n'
      'To change this setting later, edit: ${ConfigFiles.forCurrentRunMode().path}\n',
    );
    onDeclined();
    return;
  }

  await platformInstaller.performInstall(superPassword: superPassword);

  await _createDb(
    user: Constants.defaultDbUser,
    password: superPassword,
    databaseName: databaseName,
  );
}

/// Creates a database using the locally installed PostgreSQL `createdb` CLI utility.
///
/// Uses the system-installed PostgreSQL binary (not a TCP client connection).
/// Relies on local installation availability (PATH on Linux/macOS, known install dir on Windows).
///
/// Technically, this post-installation step is not strictly required
/// since this program ensures the database exists before starting the server.
/// However, this approach does not use a client connection (host, port)
/// and has a lower failure probability.
Future<void> _createDb({
  required String user,
  required String password,
  required String databaseName,
}) async {
  final executable = isWindows
      ? WindowsPostgresInstaller.binExePath('createdb')
      : 'createdb';

  try {
    final args = [
      // TODO: Workaround does not work on Fedora, instead create a dedicated database user + database owned by that user
      // Important: Forces TCP authentication instead of using a Unix socket
      // to bypass peer authentication (at least for Ubuntu's default pg_hba.conf rules, but not Fedora).
      // Peer auth requires the current Linux/macOS logged-in user to match
      // the PostgreSQL user.
      if (isUnixLike) ...['-h', '127.0.0.1'],
      '-U',
      user,
      databaseName,
    ];

    stdout.writeln(
      'Running "${buildHumanReadableCommand(executable: executable, args: args)}}" to create the database.',
    );

    final result = await Process.run(
      executable,
      args,
      environment: {'PGPASSWORD': password},
    );
    if (result.exitCode == 0) {
      stdout.writeln(
        'Database "$databaseName" created successfully (using createdb binary).',
      );
      return;
    }

    final error = result.stderr.toString();

    // Error Output (might be different if the locale is not English):
    // createdb: error: database creation failed: ERROR:  database "$databaseName" already exists
    if (error.contains('already exists')) {
      stdout.writeln('Database "$databaseName" already exists.');
      return;
    }

    stderr.writeln(
      'Failed to create database "$databaseName". Exit code: ${result.exitCode}\n'
      'PostgreSQL error output: $error',
    );
  } on Exception catch (e) {
    stderr.writeln('Failed to create "$databaseName" database: $e');
  }

  await shutdown();
  throw shutdownInvariantError;
}

bool _promptPostgresInstall({required bool hasPostgresInDocker}) {
  const dockerMessage =
      '\n\nNote: A Docker container that appears to contain PostgreSQL was detected.\n'
      'You can reject the system installation and instead manually configure the connection\n'
      'to use the PostgreSQL instance running inside Docker (host, port, username, and password).';
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

Future<PostgresPlatformInstaller?> _getPlatformInstaller() async {
  return switch (currentDesktopPlatform) {
    DesktopPlatform.linux => await () async {
      final packageManager =
          await LinuxPostgresInstaller.systemPackageManager();
      if (packageManager != null) {
        return LinuxPostgresInstaller(packageManager: packageManager);
      }
      return null;
    }(),
    DesktopPlatform.macOS => null,
    // Windows x86-32 is no longer supported
    DesktopPlatform.windows =>
      (getPlatformArchitecture().toLowerCase() == 'AMD64'.toLowerCase())
          ? WindowsPostgresInstaller()
          : null,
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
              .map(
                (executable) => WindowsPostgresInstaller.binExePath(executable),
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
