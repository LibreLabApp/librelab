import 'dart:io';

import 'package:librelab_server/src/mdns/installer/platform_installer.dart';
import 'package:librelab_server/src/mdns/platform/impls/dns_sd.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:librelab_server/src/utils/cpu_architecture.dart';
import 'package:librelab_server/src/utils/download_file.dart';
import 'package:librelab_server/src/utils/shutdown/shutdown.dart';
import 'package:path/path.dart';

/// Installs Bonjour for Windows to provide `dns-sd` command
/// **without** printer services, Apple software updater, ITunes.
///
/// Downloads the full installer file from Apple Inc, and extracts it to
/// only install `Bonjour64.msi` excluding:
///
/// - `Bonjour.msi` (32-bit version)
/// - `AppleSoftwareUpdate.msi`
/// - `BonjourPS64.msi` and `BonjourPS.msi` (print services)
/// - `SetupAdmin.exe`
final class BonjourWindowsInstaller implements MdnsPlatformInstaller {
  BonjourWindowsInstaller({required this.shutdown});

  final Shutdown shutdown;

  // From https://support.apple.com/en-us/106380
  static const String _downloadUrl =
      'https://download.info.apple.com/Mac_OS_X/061-8098.20100603.gthyu/BonjourPSSetup.exe';

  @override
  Future<void> install() async {
    final fullInstallerFile = await _downloadFullInstallerFile();
    final minimalInstallerFile = await _extractMinimalInstallerFile(
      fullInstallerFile,
    );

    await _runInstaller(minimalInstallerFile);

    // No need to add to the system PATH since dns-sd is installed in C:\Windows\System32
  }

  Future<File> _downloadFullInstallerFile() async {
    stdout.writeln('Downloading "$_downloadUrl"...');

    final savePath = join(Directory.systemTemp.path, basename(_downloadUrl));
    final file = File(savePath);

    try {
      await downloadFile(Uri.parse(_downloadUrl), file);
      stdout.writeln('Download complete: $savePath');

      return file;
    } on DownloadFileException catch (e) {
      stderr.writeln(
        'Failed to download Bonjour for Windows installer. HTTP Status: ${e.statusCode}',
      );
    } on Exception catch (e) {
      stderr.writeln('Failed to download Bonjour for Windows installer: $e');
    }

    if (file.existsSync()) {
      stdout.writeln(
        'Deleting corrupted/incomplete installer file: ${file.path}',
      );
      await file.delete();
    }

    await shutdown(isSuccess: false);
  }

  Future<File> _extractMinimalInstallerFile(File fullInstallerFile) async {
    final Directory tempExtractDir = await Directory.systemTemp.createTemp(
      '${basenameWithoutExtension(fullInstallerFile.path)}_content',
    );

    stdout.writeln(
      'Extracting files inside: "${fullInstallerFile.path}"...\n'
      'to: ${tempExtractDir.path}',
    );

    try {
      final result = await Process.run(fullInstallerFile.path, [
        '/extract',
      ], workingDirectory: tempExtractDir.path);

      if (result.exitCode == 0) {
        if (!isWindowsX64()) {
          stderr.writeln(
            'Windows is not 64-bit (x64). Bonjour installation may be incompatible.',
          );
        }
        final minimalInstallerFile = File(
          join(tempExtractDir.path, 'Bonjour64.msi'),
        );

        if (minimalInstallerFile.existsSync()) {
          final newFilePath = join(
            Directory.systemTemp.path,
            basename(minimalInstallerFile.path),
          );

          stdout.writeln(
            'Copying "${minimalInstallerFile.path}" into "$newFilePath"',
          );
          return await minimalInstallerFile.copy(newFilePath);
        }

        stderr.writeln(
          'Unexpected error: the file "${minimalInstallerFile.path}" does not exist even '
          'after extracting files from: "${fullInstallerFile.path}" (exit code is 0)',
        );
      } else {
        stderr.writeln(
          'Extracting the minimal Bonjour installer file failed with exit code: ${result.exitCode}\n'
          'Error Output: ${result.stderr}',
        );
      }
    } on Exception catch (e) {
      stderr.writeln(
        'Failed to extract the minimal Bonjour installer from: $e',
      );
    } finally {
      stdout.writeln(
        'Deleting "${fullInstallerFile.path}" and "${tempExtractDir.path}"',
      );

      await fullInstallerFile.delete();
      await tempExtractDir.delete(recursive: true);
    }

    await shutdown(isSuccess: false);
  }

  Future<void> _runInstaller(File installerFile) async {
    if (extension(installerFile.path) != '.msi') {
      throw ArgumentError.value(
        installerFile.path,
        'msiFile',
        'file extension must be msi',
      );
    }

    stdout.writeln('Installing Bonjour from "${installerFile.path}"');

    try {
      // For details about the arguments, download "https://download.info.apple.com/Mac_OS_X/061-8098.20100603.gthyu/BonjourPSSetup.exe"
      // and run BonjourPSSetup.exe --help
      final result = await Process.run('msiexec', [
        '/i',
        installerFile.path,
        '/qb!',
        '/norestart',
      ]);

      if (result.exitCode == 0) {
        stdout.writeln('Bonjour installed successfully!');
        return;
      }

      stderr.writeln(
        'Bonjour installation failed with exit code: ${result.exitCode}\n'
        'Error Output: ${result.stderr}',
      );
    } on Exception catch (e) {
      stderr.writeln('Failed to install Bonjour: $e');
    } finally {
      if (installerFile.existsSync()) {
        stdout.writeln('Deleting the installer file: ${installerFile.path}\n');
        await installerFile.delete();
      }
    }

    await shutdown(isSuccess: false);
  }

  @override
  Future<bool> isInstalled() => isCommandAvailable(DnsSdMdnsRegistrar.command);

  @override
  String get promptMessage => '''
Bonjour was not detected on this system.

For reliable local network discovery in this server,
we recommend installing it (1.74 MB).

The automated installation installs only the minimal required components
(without iTunes, printer services, or Apple Software Update).

The Bonjour installer will configure the Windows firewall appropriately during
installation on supported systems.

Note: If you have a dedicated firewall (i.e., antivirus software),
UDP port 5353 should be opened for mDNS to work correctly.
''';
}
