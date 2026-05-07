import 'dart:io';

import 'package:librelab_server/src/constants/constants.dart';
import 'package:librelab_server/src/utils/platform_check.dart';

abstract interface class PostgresPlatformInstaller {}

abstract class PostgresPlatformPackageManagerInstaller
    implements PostgresPlatformInstaller {
  Future<void> performInstall();
}

abstract class PostgresPlatformFileInstaller
    implements PostgresPlatformInstaller {
  Future<void> performInstall({required String superPassword}) async {
    final downloadUrl = buildDownloadUrl(version: PostgresConstants.version);

    final installerFile = await downloadInstallerFile(downloadUrl);
    await runSilentInstaller(
      installer: installerFile,
      superPassword: superPassword,
    );

    await addToPath();
  }

  String buildDownloadUrl({required String version}) {
    final fileSuffix = switch (currentDesktopPlatform) {
      DesktopPlatform.linux => throw UnsupportedError(
        'This method must not be called on Linux.\n'
        'The Linux installers for PostgreSQL 11 and later are deprecated.\n'
        'Consider using the platform native packages or Docker.\n'
        '- https://www.enterprisedb.com/downloads/postgres-postgresql-downloads\n'
        '- https://www.postgresql.org/download/',
      ),
      DesktopPlatform.macOS => 'osx.dmg',
      DesktopPlatform.windows => 'windows-x64.exe',
    };
    return 'https://get.enterprisedb.com/postgresql/postgresql-$version-$fileSuffix';
  }

  Future<File> downloadInstallerFile(String downloadUrl);

  Future<void> runSilentInstaller({
    required File installer,
    required String superPassword,
  });

  Future<void> addToPath();
}
