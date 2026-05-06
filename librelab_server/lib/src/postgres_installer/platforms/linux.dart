import 'dart:io';

import 'package:librelab_server/src/postgres_installer/postgres_platform_installer.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:librelab_server/src/utils/shutdown.dart';
import 'package:librelab_shared/librelab_shared.dart';

// I use Arch and GNU/Linux BTW
enum LinuxPackageManager {
  apt(executable: 'apt-get'),
  dnf(executable: 'dnf');

  const LinuxPackageManager({required this.executable});

  final String executable;
}

final class LinuxPostgresInstaller implements PostgresPlatformInstaller {
  LinuxPostgresInstaller({required LinuxPackageManager packageManager})
    : _packageManager = packageManager;

  final LinuxPackageManager _packageManager;

  static Future<LinuxPackageManager?> systemPackageManager() async {
    for (final packageManager in LinuxPackageManager.values) {
      if (await isCommandAvailable(packageManager.executable)) {
        return packageManager;
      }
    }
    return null;
  }

  @override
  Future<void> performInstall({required String superPassword}) async {
    switch (_packageManager) {
      case LinuxPackageManager.apt:
        await _installUsingApt();
      case LinuxPackageManager.dnf:
        await _installUsingDnf();
    }

    await _runCommand(
      'sudo',
      ['systemctl', 'enable', '--now', 'postgresql'],
      'start PostgreSQL now and enable automatic startup on system boot (service)',
    );

    // Important: This refers to the Linux user (usually "postgres"),
    // and not the PostgresSQL user.
    const osUser = Constants.defaultDbUser;
    // This refers to the PostgresSQL user (also usually "postgres")
    const dbUser = Constants.defaultDbUser;

    await _runCommand('sudo', [
      '-u',
      osUser,
      'psql',
      '-c',
      "ALTER USER $dbUser WITH PASSWORD '$superPassword';",
    ], 'configure PostgreSQL admin password');

    await _runCommand('systemctl', [
      'is-active',
      'postgresql',
    ], 'verify PostgreSQL service is running');
  }

  Future<void> _installUsingApt() async {
    await _runCommand('sudo', [
      'apt-get',
      'update',
    ], 'refresh package list from repositories');

    await _runCommand('sudo', [
      'apt-get',
      'install',
      '-y',
      'postgresql',
      'postgresql-contrib',
    ], 'install PostgreSQL database server and extensions');
  }

  // https://docs.fedoraproject.org/en-US/quick-docs/postgresql/
  Future<void> _installUsingDnf() async {
    await _runCommand('sudo', [
      'dnf',
      'makecache',
      '--refresh',
    ], 'refresh package list from repositories');

    await _runCommand('sudo', [
      'dnf',
      'install',
      '-y',
      'postgresql-server',
      'postgresql-contrib',
    ], 'install PostgreSQL database server and extensions');

    await _runCommand(
      'sudo',
      ['postgresql-setup', '--initdb', '--unit', 'postgresql'],
      'populate the database with initial data after installation (Fedora)',
    );
  }

  Future<Process> _runCommand(
    String executable,
    List<String> args,
    String goal,
  ) async {
    final command = buildHumanReadableCommand(
      executable: executable,
      args: args,
    );
    stdout.writeln('Running "$command" to $goal');

    final process = await runCommandStream(executable, args);
    final exitCode = await process.exitCode;

    if (exitCode == 0) {
      return process;
    }

    stderr.writeln(
      'Command failed (exit code $exitCode): "$command" while attempting to $goal.',
    );
    await shutdown();
    throw shutdownInvariantError;
  }
}
