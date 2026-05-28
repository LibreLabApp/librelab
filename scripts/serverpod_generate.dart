// Temporary workaround: https://github.com/serverpod/serverpod/issues/5002

import 'dart:io';

import 'packages.dart';

const _scriptPath = './scripts/serverpod_generate.dart';
const _clientFilePath = '${Packages.client}/lib/src/protocol/client.dart';

void main() async {
  final generateProcess = await Process.start('dart', [
    'run',
    'serverpod_cli',
    'generate',
  ], mode: .inheritStdio);

  final exitCode = await generateProcess.exitCode;
  if (exitCode != 0) {
    stderr.writeln('"serverpod generate" failed');
    exit(exitCode);
  }

  final file = File(_clientFilePath);

  if (!file.existsSync()) {
    stderr.writeln(
      'The serverpod generated Dart file was not found: $_clientFilePath',
    );
    exit(1);
  }

  final content = await file.readAsString();

  const marker = 'https://github.com/serverpod/serverpod/issues/5002';

  if (content.contains(marker)) {
    stdout.writeln('Workaround already applied. Skipping.');
    return;
  }

  final classRegex = RegExp(
    // Disclaimer: The Regex is AI-generated
    r'class\s+EndpointEmailIdp\s+extends\s+_i1\.EndpointEmailIdpBase\s*\{'
    r'\s*EndpointEmailIdp\s*\(_i2\.EndpointCaller caller\)\s*:\s*super\(caller\);\s*',
    multiLine: true,
  );

  final match = classRegex.firstMatch(content);

  if (match == null) {
    stderr.writeln('Target class not found. No changes were applied.');
    exit(1);
  }

  const insertion =
      '''
  // START: https://github.com/serverpod/serverpod/issues/5002
  // This workaround was applied by running "dart $_scriptPath"
  @override
  Future<_i1.UuidValue> startRegistration({
    required String email,
  }) async {
    // Stub implementation to satisfy the Dart compiler.
    throw UnimplementedError();
  }
  // END
''';

  final updated = content.replaceFirst(
    classRegex,
    '${match.group(0)}\n$insertion',
  );

  await file.writeAsString(updated);

  stdout.writeln('Workaround applied successfully.');
}
