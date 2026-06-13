import 'dart:io';

import 'package:librelab_server/database/postgres_constants.dart';
import 'package:librelab_server/database/postgres_installer/postgres_platform_installer.dart';
import 'package:librelab_server/database/postgres_installer/postgres_version_constants.dart';
import 'package:librelab_server/utils/cli_helpers.dart';
import 'package:librelab_server/utils/download_file.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';
import 'package:path/path.dart';
import 'package:win32_registry_value_reader/win32_registry_value_reader.dart'
    as win32;

final class WindowsPostgresInstaller extends PostgresPlatformFileInstaller {
  WindowsPostgresInstaller({required this.shutdown});

  final Shutdown shutdown;

  static String _installDir({required int majorVersion}) {
    return join('C:', 'Program Files', 'PostgreSQL', majorVersion.toString());
  }

  static String _binDir({required int majorVersion}) {
    return join(_installDir(majorVersion: majorVersion), 'bin');
  }

  /// Example:
  ///
  /// ```dart
  /// final path = binExePath(
  ///   'psql',
  ///   postgresMajorVersion: 18,
  /// );
  /// print(path); // C:\Program Files\PostgreSQL\18\psql.exe
  /// ```
  static String binExePath(
    String fileName, {
    required int postgresMajorVersion,
  }) {
    if (fileName.endsWith('.exe')) {
      throw ArgumentError.value(
        fileName,
        'fileName',
        'must not ends with .exe file extension',
      );
    }
    return join(_binDir(majorVersion: postgresMajorVersion), '$fileName.exe');
  }

  static String? windowsRegistryPostgresInstallDir() {
    for (final version in PostgresVersionInfo.values) {
      final baseDirectory = win32.readStringValueFromLocalMachine(
        keyPath:
            'SOFTWARE\\PostgreSQL\\Installations\\postgresql-x64-${version.majorVersion}',
        valueName: 'Base Directory',
      );

      if (baseDirectory != null) {
        return baseDirectory;
      }
    }

    return win32.readStringValueFromLocalMachine(
      keyPath: r'SOFTWARE\PostgreSQL Global Development Group\PostgreSQL',
      valueName: 'Location',
    );
  }

  @override
  Future<File> downloadInstallerFile(String downloadUrl) async {
    stdout.writeln('Downloading "$downloadUrl"... (may take a few minutes)');

    final savePath = join(Directory.systemTemp.path, basename(downloadUrl));
    final file = File(savePath);

    try {
      await downloadFile(Uri.parse(downloadUrl), file);
      stdout.writeln('Download complete: $savePath');

      return file;
    } on DownloadFileException catch (e) {
      stderr.writeln(
        'Failed to download PostgreSQL installer. HTTP Status: ${e.statusCode}',
      );
    } on Exception catch (e) {
      stderr.writeln('Failed to download PostgreSQL installer: $e');
    }

    if (file.existsSync()) {
      stdout.writeln(
        'Deleting corrupted/incomplete installer file: ${file.path}',
      );
      await file.delete();
    }

    await shutdown(isSuccess: false);
  }

  @override
  Future<void> runInstaller({
    required File installer,
    required String superPassword,
  }) async {
    stdout.writeln(
      'Installer file: ${installer.path}\n'
      'Starting PostgreSQL installation... This may take 1-5 minutes.',
    );

    try {
      // Details about the arguments can be found in: docs/POSTGRES_WINDOWS_INSTALLER_HELP.txt
      final args = <String, String>{
        'mode': 'unattended',
        'unattendedmodeui': 'minimal',
        'superpassword': superPassword,
        'install_runtimes': '1',
        'locale': 'en-US',
        'installer-language': 'en',
        'serverport': PostgresConstants.defaultPort.toString(),
        'superaccount': PostgresConstants.defaultDbUser,
      };

      final argsList = args.entries
          .expand((e) => ['--${e.key}', e.value])
          .toList();

      final result = await Process.run(
        installer.path,
        argsList,
        runInShell: true, // Important for Windows UAC prompt
      );
      if (result.exitCode == 0) {
        stdout.writeln('PostgreSQL installed successfully!');
        return;
      }

      stderr.writeln(
        'PostgreSQL installation failed with exit code: ${result.exitCode}\n'
        'Error Output: ${result.stderr}',
      );
    } on Exception catch (e) {
      stderr.writeln('Failed to install PostgreSQL: $e');
    } finally {
      if (installer.existsSync()) {
        stdout.writeln('Deleting downloaded installer file: ${installer.path}');
        await installer.delete();
      }
    }

    await shutdown(isSuccess: false);
  }

  @override
  Future<void> addToPath({required int majorVersion}) async {
    final binDirectory = _binDir(majorVersion: majorVersion);
    stdout.writeln('Adding "$binDirectory" to user PATH...');

    try {
      final exitCode = await ensureDirectoryInWindowsUserPath(binDirectory);
      if (exitCode == 0) {
        stdout.writeln('Successfully added "$binDirectory" to user PATH.');
        return;
      }

      stderr.writeln(
        'Failed to add "$binDirectory" to user PATH '
        '(exit code: $exitCode).',
      );
    } on Exception catch (e) {
      stderr.writeln('Error while adding "$binDirectory" to user PATH: $e');
    }
  }
}
