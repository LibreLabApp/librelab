import 'dart:io';

import 'package:librelab_server/database/postgres_installer/postgres_version_constants.dart';
import 'package:librelab_server/utils/platform_check.dart';
import 'package:librelab_server/utils/security/checksum_verifier.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';

sealed class PostgresPlatformInstaller._();

abstract interface class PostgresPlatformPackageManagerInstaller
    implements PostgresPlatformInstaller {
  Future<void> performInstall({required PostgresVersionInfo versionInfo});
}

abstract class PostgresPlatformFileInstaller({
  required final Shutdown _shutdown,
}) implements PostgresPlatformInstaller {
  Future<void> performInstall({
    required String superPassword,
    required PostgresVersionInfo versionInfo,
  }) async {
    final downloadUrl = buildDownloadUrl(version: versionInfo.fullVersion);

    final installerFile = await downloadInstallerFile(downloadUrl);
    await verifyDownloadedFileIntegrity(installerFile, versionInfo);

    await runInstaller(installer: installerFile, superPassword: superPassword);

    await addToPath(majorVersion: versionInfo.majorVersion);
  }

  UnsupportedError _linuxUnsupported() => throw UnsupportedError(
    'This method must not be called on Linux.\n'
    'The Linux installers for PostgreSQL 11 and later are deprecated.\n'
    'Consider using the platform native packages or Docker.\n'
    '- https://www.enterprisedb.com/downloads/postgres-postgresql-downloads\n'
    '- https://www.postgresql.org/download/',
  );

  String buildDownloadUrl({required String version}) {
    final fileSuffix = switch (currentDesktopPlatform) {
      .linux => throw _linuxUnsupported(),
      .macOS => 'osx.dmg',
      .windows => 'windows-x64.exe',
    };
    return 'https://get.enterprisedb.com/postgresql/postgresql-$version-$fileSuffix';
  }

  Future<File> downloadInstallerFile(String downloadUrl);

  Future<void> verifyDownloadedFileIntegrity(
    File file,
    PostgresVersionInfo versionInfo,
  ) async {
    final expected = switch (currentDesktopPlatform) {
      .linux => throw _linuxUnsupported(),
      .macOS => throw UnsupportedError(
        'Currently, macOS SHA-256 checksum values are unavailable',
      ),
      .windows => versionInfo.windowsInstallerSha256,
    };

    stdout.writeln(
      'Verifying installer file integrity (SHA-256): ${file.path}',
    );
    final isValid = await verifySha256(file, expected);

    if (!isValid) {
      stderr.writeln(
        'PostgreSQL ${versionInfo.fullVersion} installer checksum verification failed. '
        'The downloaded file may be corrupted or has been modified.',
      );
      await file.delete();
      await _shutdown(isSuccess: false);
    }
  }

  Future<void> runInstaller({
    required File installer,
    required String superPassword,
  });

  Future<void> addToPath({required int majorVersion});
}
