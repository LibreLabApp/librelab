import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:librelab_server/src/utils/platform_check.dart';
import 'package:path/path.dart' as p;

// ignore: depend_on_referenced_packages
export 'package:librelab_server/src/utils/platform_check.dart';

void ensureWorkingDirectory(String packageName) {
  final currentDirectory = Directory.current;
  if (currentDirectory.path.endsWith(packageName)) {
    return;
  }
  final newDirectory = Directory(p.join(currentDirectory.path, packageName));
  final pubspec = File(p.join(newDirectory.path, 'pubspec.yaml'));
  final isValidPubspec =
      pubspec.existsSync() &&
      pubspec.readAsStringSync().contains('name: $packageName');
  if (!isValidPubspec) {
    stderr.writeln('Could not find the path of the package: $packageName');
    exit(1);
  }

  Directory.current = newDirectory;
  stdout.writeln('Changed working directory to: $packageName');
}

Future<void> makeExecutable(String filePath) async {
  if (!isUnixLike) {
    throw UnsupportedError(
      'makeExecutable() must be called only on Linux/macOS',
    );
  }
  final chmodResult = await Process.run('chmod', ['+x', filePath]);

  if (chmodResult.exitCode != 0) {
    stderr.writeln(
      'Failed to make "$filePath" executable.\n'
      'Error output: ${chmodResult.stderr}',
    );
    exit(chmodResult.exitCode);
  }
}

final scriptRelativePath = p.relative(
  Platform.script.toFilePath(),
  from: Directory.current.path,
);
