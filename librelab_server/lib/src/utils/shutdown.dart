import 'dart:io';

import 'package:serverpod/serverpod.dart';

/// Strongly prefer this method over direct [exit] for a graceful shutdown.
///
/// ```dart
/// await shutdown(exitProcess: true);
/// throw shutdownInvariantError;
/// ```
Future<void> shutdown({bool exitProcess = true, int? signalNumber}) async {
  await Serverpod.instance.shutdown(
    exitProcess: exitProcess,
    signalNumber: signalNumber,
  );
}

final class ShutdownError extends Error {
  ShutdownError(this.message);

  final String message;

  @override
  String toString() => 'ShutdownError: $message';
}

/// Indicates that program execution continued after a shutdown that was expected
/// to terminate the process.
///
/// This is a contract violation: if `shutdown(exitProcess: true)` is called,
/// control flow should not proceed beyond it due to `dart:io`'s `exit()`.
ShutdownError get shutdownInvariantError => ShutdownError(
  'Unexpected continuation after shutdown(exitProcess: true). '
  'Process termination via dart:io exit() did not occur. '
  'Either `exitProcess` is `false` or `shutdown` has a bug.',
);
