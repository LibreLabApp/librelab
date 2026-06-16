import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart'
    show ApiContractVersionConstants;
import 'package:librelab_server/cli/cli_constants.dart';
import 'package:librelab_server/config/server_run_mode.dart';
import 'package:librelab_server/generated/pubspec.g.dart' show Pubspec;
import 'package:librelab_server/utils/cli_helpers.dart';
import 'package:librelab_server/utils/cpu_architecture.dart';
import 'package:path/path.dart';

import '../../scripts/_utils.dart';
import '../../scripts/packages.dart';

const _package = Packages.server;
const _executableFileNameWithoutExt = 'librelab_server';

final _usingZipCommand = isUnixLike;

void main() async {
  _validateApiContractVersions();

  if (_usingZipCommand && !(await isCommandAvailable('zip'))) {
    stderr.writeln(
      'Please install "zip" using your system package manager.\nE.g., sudo apt install zip',
    );
    exit(1);
  }

  final buildDirectory = Directory(join(Directory.current.path, 'build'));

  final targetDirectory = Directory(join(buildDirectory.path, _package));
  await targetDirectory.create(recursive: true);

  final executableFileName =
      '$_executableFileNameWithoutExt${isWindows ? '.exe' : ''}';

  final executablePath = join(targetDirectory.path, executableFileName);

  final compileResult = await Process.start('dart', [
    'compile',
    'exe',
    'bin/main.dart',
    '-o',
    executablePath,
  ], mode: .inheritStdio);

  final exitCode = await compileResult.exitCode;
  if (exitCode != 0) {
    stderr.writeln('Failed to compile the Dart program.');
    exit(1);
  }

  final runScriptFile = await _buildRunScript(
    targetDirectory: targetDirectory.path,
    executableFileName: executableFileName,
  );

  await _buildCreateSuperUserScript(
    targetDirectory: targetDirectory.path,
    executableFileName: executableFileName,
    runScriptFile: runScriptFile,
  );

  await _copyProjectInfoFiles(targetDirectory.path);

  await _buildZipFile(
    buildDirectory: buildDirectory,
    targetDirectory: targetDirectory,
  );

  stdout.writeln('Done.');
}

enum _ScriptExt {
  sh(fileExtension: 'sh'),
  bat(fileExtension: 'bat');

  const _ScriptExt({required this.fileExtension});

  final String fileExtension;

  static _ScriptExt get forCurrentOs => switch (currentDesktopPlatform) {
    DesktopPlatform.linux => .sh,
    DesktopPlatform.macOS => .sh,
    DesktopPlatform.windows => .bat,
  };
}

_ScriptExt _scriptExt = _ScriptExt.forCurrentOs;

Future<File> _buildRunScript({
  required String targetDirectory,
  required String executableFileName,
}) async {
  final args =
      '--${CliOptions.serverRunModeOption} ${ServerRunMode.production.cliValue} --${CliOptions.applyMigrationsFlag}';

  final fileExtension = _scriptExt.fileExtension;
  final file = File(join(targetDirectory, 'run.$fileExtension'));

  final fileContent = switch (_scriptExt) {
    _ScriptExt.sh =>
      '''
#!/usr/bin/env sh

exec "\$(dirname "\$0")/$executableFileName" $args "\$@"
''',
    _ScriptExt.bat =>
      '''
@echo off
set DIR=%~dp0

"%DIR%$executableFileName" $args %*

echo.
echo Program execution finished or interrupted.
pause
  ''',
  };

  await file.writeAsString(fileContent);

  if (isUnixLike) {
    await makeExecutable(file.path);
  }

  return file;
}

Future<void> _buildCreateSuperUserScript({
  required String targetDirectory,
  required String executableFileName,
  required File runScriptFile,
}) async {
  final runScriptFileName = basename(runScriptFile.path);

  final fileExtension = _scriptExt.fileExtension;
  final file = File(join(targetDirectory, 'create-superuser.$fileExtension'));

  const argument = '--${CliOptions.createSuperUserFlag}';

  final fileContent = switch (_scriptExt) {
    _ScriptExt.sh =>
      '''
#!/usr/bin/env sh

SCRIPT_DIR="\$(cd "\$(dirname "\$0")" && pwd)"

sh "\$SCRIPT_DIR/$runScriptFileName" $argument
''',
    _ScriptExt.bat =>
      '''
@echo off

set "SCRIPT_DIR=%~dp0"

call "%SCRIPT_DIR%$runScriptFileName" $argument

echo Done
  ''',
  };

  await file.writeAsString(fileContent);

  if (isUnixLike) {
    await makeExecutable(file.path);
  }
}

Future<void> _copyProjectInfoFiles(String targetDirectory) async {
  final files = <String>['LICENSE', 'README.md'];
  for (final file in files) {
    await File('../$file').copy(join(targetDirectory, file));
  }
}

Future<void> _buildZipFile({
  required Directory buildDirectory,
  required Directory targetDirectory,
}) async {
  final normalizedArchitecture = getNormalizedPlatformArchitecture();

  final platform = '${Platform.operatingSystem}-$normalizedArchitecture';

  final outputFileName = '${_package}_${Pubspec.version}_$platform.zip';
  final outputFilePath = join(buildDirectory.path, outputFileName);

  if (_usingZipCommand) {
    // Uses system "zip" utility to create archive
    // while preserving executable permissions
    final zipResult = await Process.run('zip', [
      '-r',
      '-q',
      outputFilePath,
      basename(targetDirectory.path),
    ], workingDirectory: targetDirectory.parent.path);

    if (zipResult.exitCode != 0) {
      stderr.writeln('Failed to archive "${targetDirectory.path}".');
      stderr.writeln(zipResult.stderr);
      exit(zipResult.exitCode);
    }
    return;
  }

  final encoder = ZipFileEncoder();

  encoder.create(outputFilePath);
  await encoder.addDirectory(targetDirectory);
  await encoder.close();
}

void _validateApiContractVersions() {
  const version = ApiContractVersionConstants.version;
  const minSupportedVersion = ApiContractVersionConstants.minSupportedVersion;

  if (version < minSupportedVersion) {
    stderr.writeln(
      'Invalid API contract version: version is lower than minimum supported version.\n'
      'version=$version, '
      'minSupported=$minSupportedVersion. '
      'This indicates a build-time contract mismatch.',
    );
    exit(1);
  }
}
