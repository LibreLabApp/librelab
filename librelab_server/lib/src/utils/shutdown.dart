import 'dart:io';

import 'package:serverpod/serverpod.dart';

/// Strongly prefer this method over direct [exit] for a graceful shutdown.
///
/// ```dart
/// await shutdown();
/// throw shutdownInvariantError;
/// ```
Future<void> shutdown({required bool isSuccess}) async {
  final exitCode = isSuccess ? 0 : 1;

  final Serverpod pod;
  try {
    pod = Serverpod.instance;
  } on Exception catch (_) {
    // Workaround: Serverpod may potentially not be initialized yet at this point.
    //
    // We may want to call this method before initializing/starting Serverpod,
    // e.g, when finding an available port or generating config.
    // Initializing Serverpod require valid config (even without starting the server).

    // https://github.com/serverpod/serverpod/blob/main/packages/serverpod/lib/src/server/serverpod.dart#L1321-L1333
    try {
      await stdout.flush();
    } on Exception {
      // No-op
    }
    try {
      await stderr.flush();
    } on Exception {
      // No-op
    }

    exit(exitCode);
  }

  // Prevents Serverpod from exiting the process and exit manually
  // since it does not allow passing raw exit code argument (not Unix signal)
  await pod.shutdown(exitProcess: false);
  exit(exitCode);
}

/// {@macro shutdown_error}
final class ShutdownError extends Error {
  ShutdownError(this.message);

  final String message;

  @override
  String toString() => 'ShutdownError: $message';
}

/// {@template shutdown_error}
/// Indicates that program execution continued after a shutdown that was expected
/// to terminate the process.
///
/// This is a contract violation: if [shutdown] is called,
/// control flow should not proceed beyond it due to `dart:io`'s `exit()`.
/// {@endtemplate}
ShutdownError get shutdownInvariantError => ShutdownError(
  'Unexpected continuation after shutdown(). '
  'Process termination via dart:io exit() did not occur. '
  '`shutdown()` may have a bug.',
);
