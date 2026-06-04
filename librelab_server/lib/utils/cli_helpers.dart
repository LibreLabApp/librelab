import 'dart:convert';
import 'dart:io';

import 'package:librelab_server/utils/platform_check.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';
import 'package:path/path.dart';

int humanExitCode(int code) {
  if (!isUnixLike) {
    return code;
  }
  if (code < 0) {
    return 128 - code;
  }
  return code;
}

String buildHumanReadableCommand({
  required String executable,
  required List<String> args,
}) {
  return '$executable ${args.join(' ')}';
}

Future<bool> isCommandAvailable(String command) async {
  try {
    final result = await Process.run(isWindows ? 'where' : 'which', [command]);
    if (result.exitCode != 0) {
      return false;
    }

    final output = (result.stdout as String).trim();
    return output.isNotEmpty;
  } on Exception catch (_) {
    return false;
  }
}

Future<int> ensureDirectoryInWindowsUserPath(String directory) async {
  if (!isWindows) {
    throw UnsupportedError(
      'ensureDirectoryInWindowsUserPath() must not be called on non-Windows systems.',
    );
  }

  // Normalizes path separators for consistency in PowerShell usage.
  final windowsPath = windows.normalize(directory);

  final script =
      '''
    \$p = [Environment]::GetEnvironmentVariable('Path', 'User');
    if (\$p -split ';' -notcontains '$windowsPath') {
      [Environment]::SetEnvironmentVariable('Path', "\$p;$windowsPath", 'User')
    }
  ''';

  final result = await Process.run('powershell', ['-Command', script]);
  return result.exitCode;
}

Future<Process> executeCommandStream(
  String executable,
  List<String> args, {
  Map<String, String>? environment,
}) async {
  final process = await Process.start(
    executable,
    args,
    environment: environment,
  );

  process.stderr.transform(utf8.decoder).transform(const LineSplitter()).listen(
    (line) {
      stderr.writeln('[$executable stderr] $line');
    },
  );

  process.stdout.transform(utf8.decoder).transform(const LineSplitter()).listen(
    (line) {
      stdout.writeln('[$executable stdout] $line');
    },
  );

  return process;
}

Future<Process> executeAndLogCommandOrShutdown(
  String executable,
  List<String> args,
  String goal, {
  Map<String, String>? environment,
  required Shutdown shutdown,
}) async {
  final command = buildHumanReadableCommand(executable: executable, args: args);
  stdout.writeln('\nRunning "$command" to $goal\n');

  final process = await executeCommandStream(
    executable,
    args,
    environment: environment,
  );
  final exitCode = await process.exitCode;

  if (exitCode == 0) {
    return process;
  }

  stderr.writeln(
    'Command failed (exit code $exitCode): "$command" while attempting to $goal.',
  );
  await shutdown(isSuccess: false);
}
