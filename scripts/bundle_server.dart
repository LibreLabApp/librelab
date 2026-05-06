// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:io/io.dart';
import 'package:librelab_server/generated/pubspec.g.dart' show Pubspec;
import 'package:librelab_server/src/config/config_files.dart';
import 'package:librelab_server/src/utils/cpu_architecture.dart';
import 'package:librelab_shared/src/constants/constants.dart';
import 'package:librelab_shared/src/constants/project_constants.dart';
import 'package:path/path.dart';

import '_utils.dart';
import 'packages.dart';

const _package = Packages.server;

void main() async {
  ensureWorkingDirectory(_package);

  final buildDirectory = Directory(join(Directory.current.path, 'build'));

  final targetDirectory = Directory(join(buildDirectory.path, _package));
  await targetDirectory.create(recursive: true);

  final executableFileName = 'main${isWindows ? '.exe' : ''}';

  final executablePath = join(targetDirectory.path, executableFileName);

  final compileResult = await Process.run('dart', [
    'compile',
    'exe',
    'bin/main.dart',
    '-o',
    executablePath,
  ]);

  if (compileResult.exitCode != 0) {
    stderr.writeln('Failed to compile the Dart program.');
    stderr.writeln(compileResult.stderr);
    exit(compileResult.exitCode);
  }

  final runScriptFile = await _buildRunScript(
    targetDirectory: targetDirectory.path,
    executableFileName: executableFileName,
  );

  await _buildForceCreateAdminScript(
    targetDirectory: targetDirectory.path,
    executableFileName: executableFileName,
    runScriptFile: runScriptFile,
  );

  await _createConfigFiles(targetDirectory.path);

  await _copyMigrationFiles(targetDirectory.path);

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
  const args =
      '--mode production --logging normal --role monolith --apply-migrations';

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

Future<void> _buildForceCreateAdminScript({
  required String targetDirectory,
  required String executableFileName,
  required File runScriptFile,
}) async {
  final runScriptFileName = basename(runScriptFile.path);

  final fileExtension = _scriptExt.fileExtension;
  final file = File(
    join(targetDirectory, 'force-create-admin-user.$fileExtension'),
  );

  const argument = Constants.forceCreateAdminArgument;

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

Future<void> _createConfigFiles(String targetDirectory) async {
  final configDirectory = Directory(
    join(targetDirectory, ConfigFileNames.configRoot),
  );
  await configDirectory.create();

  final productionConfigFile = File(
    join(configDirectory.path, ConfigFileNames.production),
  );

  await productionConfigFile.writeAsString('''
# Important: When deploying the server to the cloud (not required for local networks):
#
# 1. Route traffic through a reverse proxy or load balancer to provide SSL security (HTTPS), e.g.,
# 2. Update host, port, and scheme values for both the API server and database.
# 3. Set requireSsl to true

apiServer:
  port: ${ProjectConstants.defaultApiPort}
  publicHost: localhost
  publicPort: ${ProjectConstants.defaultApiPort}
  publicScheme: http

# insightsServer:
#   port: ${ProjectConstants.defaultInsightsPort}
#   publicHost: localhost
#   publicPort: ${ProjectConstants.defaultInsightsPort}
#   publicScheme: http

database:
  host: localhost
  port: ${Constants.defaultPostgresPort}
  name: ${ProjectConstants.defaultDbName}
  user: ${Constants.defaultDbUser}
  requireSsl: false

# The maximum size of requests allowed in bytes
maxRequestSize: 524288 # 512 KB

sessionLogs:
  consoleEnabled: false
# persistentEnabled: true
''');
}

Future<void> _copyMigrationFiles(String targetDirectory) async {
  const migrationsDir = 'migrations';

  final destination = join(targetDirectory, migrationsDir);
  await copyPath(migrationsDir, destination);
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
  final platformArchitecture = getPlatformArchitecture();
  final normalizedArchitecture = isWindows && platformArchitecture == 'AMD64'
      ? 'x64'
      : platformArchitecture;
  final platform = '${Platform.operatingSystem}-$normalizedArchitecture';

  final outputFileName = '${_package}_${Pubspec.version}_$platform.zip';
  final outputFilePath = join(buildDirectory.path, outputFileName);

  if (isUnixLike) {
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
