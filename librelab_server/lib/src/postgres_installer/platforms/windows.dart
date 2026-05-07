import 'dart:io';

import 'package:librelab_server/src/constants/constants.dart';
import 'package:librelab_server/src/postgres_installer/postgres_platform_installer.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:librelab_server/src/utils/shutdown.dart';
import 'package:path/path.dart';
import 'package:win32_registry_value_reader/win32_registry_value_reader.dart'
    as win32;

final class WindowsPostgresInstaller extends PostgresPlatformFileInstaller {
  static String get _installDir =>
      'C:\\Program Files\\PostgreSQL\\${PostgresConstants.majorVersion}';
  static String get _binDir => join(_installDir, 'bin');

  static String binExePath(String fileName) {
    if (fileName.endsWith('.exe')) {
      throw ArgumentError.value(
        fileName,
        'fileName',
        'must not ends with .exe file extension',
      );
    }
    return join(_binDir, '$fileName.exe');
  }

  static String? windowsRegistryPostgresInstallDir() {
    return win32.readStringValueFromLocalMachine(
          keyPath: r'SOFTWARE\PostgreSQL Global Development Group\PostgreSQL',
          valueName: 'Location',
        ) ??
        win32.readStringValueFromLocalMachine(
          keyPath:
              'SOFTWARE\\PostgreSQL\\Installations\\postgresql-x64-${PostgresConstants.majorVersion}',
          valueName: 'Base Directory',
        );
  }

  @override
  Future<File> downloadInstallerFile(String downloadUrl) async {
    stdout.writeln('Downloading "$downloadUrl"... (may take a few minutes)');

    final httpClient = HttpClient();
    final request = await httpClient.getUrl(Uri.parse(downloadUrl));
    final response = await request.close();

    final savePath = join(Directory.systemTemp.path, basename(downloadUrl));
    final file = File(savePath);

    try {
      if (response.statusCode == 200) {
        await response.pipe(file.openWrite());
        stdout.writeln('Download complete: $savePath');
        return file;
      }

      stderr.writeln(
        'Failed to download PostgreSQL installer. HTTP Status: ${response.statusCode}',
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

    await shutdown();
    throw shutdownInvariantError;
  }

  @override
  Future<void> runSilentInstaller({
    required File installer,
    required String superPassword,
  }) async {
    stdout.writeln(
      'Installer file: ${installer.path}\n'
      'Starting PostgreSQL silent installation... This may take 1-5 minutes.',
    );

    try {
      final args = <String, String>{
        'mode': 'unattended',
        'unattendedmodeui': 'minimal',
        'superpassword': superPassword,
        'install_runtimes': '1',
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
        'PostgreSQL silent installation failed with exit code: ${result.exitCode}\n'
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

    await shutdown();
    throw shutdownInvariantError;
  }

  @override
  Future<void> addToPath() async {
    final binDirectory = _binDir;
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
