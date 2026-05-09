import 'dart:io';

import 'package:librelab_server/src/postgres_installer/postgres_platform_installer.dart';
import 'package:librelab_server/src/postgres_installer/postgres_version_constants.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:librelab_server/src/utils/cpu_architecture.dart';
import 'package:librelab_server/src/utils/shutdown.dart';

// I use Arch and GNU/Linux BTW
enum LinuxPackageManager {
  apt(executable: 'apt-get'),
  dnf(executable: 'dnf');

  const LinuxPackageManager({required this.executable});

  final String executable;
}

final class LinuxPostgresInstaller
    implements PostgresPlatformPackageManagerInstaller {
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
  Future<void> performInstall({
    required PostgresVersionInfo versionInfo,
  }) async {
    switch (_packageManager) {
      case LinuxPackageManager.apt:
        await _installUsingApt(majorVersion: versionInfo.majorVersion);
      case LinuxPackageManager.dnf:
        await _installUsingDnf(majorVersion: versionInfo.majorVersion);
    }
  }

  // https://www.postgresql.org/download/linux/ubuntu/
  Future<void> _installUsingApt({required String majorVersion}) async {
    await _runCommand('sudo', [
      'apt-get',
      'update',
    ], 'refresh package list from repositories');

    await _runCommand('sudo', [
      'apt-get',
      'install',
      '-y',
      'postgresql-common',
    ], 'install PostgreSQL to run PGDG repository setup script');

    // This script runs "apt-get update" internally. No need to re-run for the third time
    await _runCommand(
      'sudo',
      ['/usr/share/postgresql-common/pgdg/apt.postgresql.org.sh', '-y'],
      'install official PostgreSQL (PGDG) APT repository for access to PostgreSQL versions',
    );

    await _runCommand('sudo', [
      'apt-get',
      'install',
      '-y',
      'postgresql-$majorVersion',
      'postgresql-contrib-$majorVersion',
    ], 'install PostgreSQL database server and extensions');

    await _enablePostgresServiceNow('postgresql@$majorVersion-main');
  }

  // - https://www.postgresql.org/download/linux/redhat/ (preferred)
  // - https://docs.fedoraproject.org/en-US/quick-docs/postgresql/
  Future<void> _installUsingDnf({required String majorVersion}) async {
    await _runCommand('sudo', [
      'dnf',
      'makecache',
      '--refresh',
    ], 'refresh package list from repositories');

    await _runCommand(
      'sudo',
      ['dnf', 'install', '-y', await _buildPgdgRpmUrl()],
      'install official PostgreSQL (PGDG) RPM repository for access to PostgreSQL versions',
    );

    await _runCommand('sudo', [
      'dnf',
      'install',
      '-y',
      'postgresql$majorVersion-server',
      'postgresql$majorVersion-contrib',
    ], 'install PostgreSQL database server and extensions');

    await _runCommand(
      'sudo',
      ['/usr/pgsql-$majorVersion/bin/postgresql-$majorVersion-setup', 'initdb'],
      'initialize the database (post-installation, Red Hat family distributions, e.g., Fedora)',
    );

    await _enablePostgresServiceNow('postgresql-$majorVersion');
  }

  Future<void> _enablePostgresServiceNow(String serviceName) async {
    await _runCommand(
      'sudo',
      ['systemctl', 'enable', '--now', serviceName],
      'start PostgreSQL now and enable automatic startup on system boot (service)',
    );

    await _runCommand('systemctl', [
      'is-active',
      serviceName,
    ], 'verify PostgreSQL service is running');

    await _runCommand('systemctl', [
      'is-enabled',
      serviceName,
    ], 'verify PostgreSQL service is enabled');
  }

  Future<String> _buildPgdgRpmUrl() async {
    final osReleaseFile = File('/etc/os-release');
    final osReleaseLines = await osReleaseFile.readAsLines();

    String? extract(String key) {
      for (final line in osReleaseLines) {
        if (!line.startsWith(key)) {
          continue;
        }

        final value = line.replaceFirst('$key=', '');
        final normalizedValue = value.startsWith('"') && value.endsWith('"')
            ? value.substring(1, line.length - 1)
            : value;

        return normalizedValue;
      }

      return null;
    }

    final id = extract('ID')?.toLowerCase();
    final versionId = extract('VERSION_ID');

    if (id == null || versionId == null) {
      stderr.writeln(
        'Failed to detect Linux distribution from "${osReleaseFile.path}".\n'
        'This is needed to build the RPM repository URL, which requires ID and VERSION_ID.',
      );
      await shutdown();
      throw shutdownInvariantError;
    }

    if (id != 'fedora') {
      stderr.writeln('Unsupported Red Hat family distribution: $id');

      await shutdown();
      throw shutdownInvariantError;
    }

    final architecture = getRawPlatformArchitecture();
    if (architecture != 'x86_64') {
      stderr.writeln('Unsupported CPU architecture: $architecture');

      await shutdown();
      throw shutdownInvariantError;
    }

    // Assumes Fedora Linux
    return 'https://download.postgresql.org/pub/repos/yum/reporpms/F-$versionId-$architecture/pgdg-fedora-repo-latest.noarch.rpm';
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
    stdout.writeln('\nRunning "$command" to $goal\n');

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
