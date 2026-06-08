import 'dart:io';

import 'package:librelab_server/database/postgres_installer/postgres_platform_installer.dart';
import 'package:librelab_server/database/postgres_installer/postgres_version_constants.dart';
import 'package:librelab_server/utils/cli_helpers.dart';
import 'package:librelab_server/utils/cpu_architecture.dart';
import 'package:librelab_server/utils/linux/linux_os_release.dart';
import 'package:librelab_server/utils/linux/linux_package_manager.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';

/// **Note**: For various reasons, the PostgreSQL package is installed from the
/// official PGDG repository instead the distribution's one:
///
/// 1. Pinning to a specific major version (e.g., 18). The default package version
///    is coupled to the OS version. This ensures the server will not break
///    due to an incompatible PostgreSQL version during system updates.
///
/// 2. Newer updates and security patches.
///
/// 3. Fragmented `pg_hba.conf` rules: In some Linux distributions,
/// such as Fedora Linux (not applicable to Ubuntu, Linux Mint, or PopOS),
/// the default pg_hba.conf rules provided by the distribution
/// may force Ident authentication, which causes the app connection to fail
///
/// Workaround: In pg_hba.conf, replace TCP authentication from "ident" to "scram-sha-256"
/// (file location varies by OS).
/// For example, on Fedora: /var/lib/pgsql/data/pg_hba.conf
/// Then restart PostgreSQL service for the fix to take affect.
///
/// More details:
///
/// - https://stackoverflow.com/questions/50098688/postgresql-ident-authentication-failed-on-fedora
/// - https://docs.fedoraproject.org/en-US/quick-docs/postgresql/#pg_hba.conf
///
/// The above workaround is **not** appropriate for a script.
/// Instead we rely on the official PostgreSQL repository.
final class LinuxPostgresInstaller
    implements PostgresPlatformPackageManagerInstaller {
  LinuxPostgresInstaller({
    required this._packageManager,
    required this._linuxOsRelease,
    required this.shutdown,
  });

  final LinuxPackageManager _packageManager;
  final LinuxOsRelease _linuxOsRelease;
  final Shutdown shutdown;

  static Future<LinuxPackageManager?> systemPackageManager() async {
    for (final packageManager in LinuxPackageManager.values) {
      if (packageManager == .pacman) {
        // Currently, Arch Linux is unsupported but typically users
        // prefer to compile from source anyway.
        continue;
      }
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
    final majorVersion = versionInfo.majorVersion;

    switch (_packageManager) {
      case .apt:
        await _installUsingApt(majorVersion: majorVersion);
      case .dnf:
        await _installUsingDnf(majorVersion: majorVersion);
      case .pacman:
        throw UnsupportedError(
          'Programming error (should never be thrown!). I use Arch BTW',
        );
    }
  }

  // https://www.postgresql.org/download/linux/ubuntu/
  Future<void> _installUsingApt({required int majorVersion}) async {
    await _runCommand(
      'sudo',
      ['apt-get', 'update'],
      'refresh package list from repositories',
      environment: LinuxPackageManager.aptNonInteractiveEnv,
    );

    final codename = await _linuxOsRelease.detectAptBaseCodename();

    if (codename == null) {
      stderr.writeln(
        'Unable to determine APT distribution codename from: ${LinuxOsRelease.filePath}',
      );

      await shutdown(isSuccess: false);
    }

    await _runCommand(
      'sudo',
      ['apt-get', 'install', '-y', 'postgresql-common'],
      'install PostgreSQL to run PGDG repository setup script',
      environment: LinuxPackageManager.aptNonInteractiveEnv,
    );

    // This script runs "apt-get update" internally. No need to re-run for the third time
    await _runCommand(
      'sudo',
      [
        '/usr/share/postgresql-common/pgdg/apt.postgresql.org.sh',
        '-y', // IMPORTANT: Positioned argument (must not be after the codename)
        codename,
      ],
      'install official PostgreSQL (PGDG) APT repository for access to PostgreSQL versions',
      // The script uses apt internally
      environment: LinuxPackageManager.aptNonInteractiveEnv,
    );

    await _runCommand(
      'sudo',
      [
        'apt-get',
        'install',
        '-y',
        'postgresql-$majorVersion',
        'postgresql-contrib-$majorVersion',
      ],
      'install PostgreSQL database server and extensions',
      environment: LinuxPackageManager.aptNonInteractiveEnv,
    );

    await _enablePostgresServiceNow('postgresql@$majorVersion-main');
  }

  // - https://www.postgresql.org/download/linux/redhat/ (preferred)
  // - https://docs.fedoraproject.org/en-US/quick-docs/postgresql/
  Future<void> _installUsingDnf({required int majorVersion}) async {
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
    final id = (await _linuxOsRelease.readValue('ID'))?.toLowerCase();
    final versionId = await _linuxOsRelease.readValue('VERSION_ID');

    if (id == null || versionId == null) {
      stderr.writeln(
        'Failed to detect Red Hat Linux distribution from "${LinuxOsRelease.filePath}".\n'
        'This is needed to build the RPM repository URL, which requires ID and VERSION_ID.',
      );
      await shutdown(isSuccess: false);
    }

    if (id != 'fedora') {
      stderr.writeln('Unsupported Red Hat family distribution: $id');

      await shutdown(isSuccess: false);
    }

    final architecture = getRawPlatformArchitecture();
    if (architecture != 'x86_64') {
      stderr.writeln('Unsupported CPU architecture: $architecture');

      await shutdown(isSuccess: false);
    }

    // Assumes Fedora Linux
    return 'https://download.postgresql.org/pub/repos/yum/reporpms/F-$versionId-$architecture/pgdg-fedora-repo-latest.noarch.rpm';
  }

  Future<Process> _runCommand(
    String executable,
    List<String> args,
    String goal, {
    Map<String, String>? environment,
  }) => executeAndLogCommandOrShutdown(
    executable,
    args,
    goal,
    environment: environment,
    shutdown: shutdown,
  );
}
