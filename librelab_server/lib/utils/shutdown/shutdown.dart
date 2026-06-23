import 'dart:io';

import 'package:librelab_server/utils/shutdown/shutdown_hook_registry.dart';

class Shutdown({required final ShutdownHookRegistry _hookRegistry}) {
  /// Prefers this method over direct [exit] for a graceful shutdown.
  ///
  /// ```dart
  /// await shutdown();
  /// ```
  Future<Never> call({required bool isSuccess}) async {
    stderr.writeln('\n-- Shutdown started --');

    for (final entry in _hookRegistry.hooks.entries) {
      final (id, hook) = (entry.key, entry.value);

      try {
        await hook();
      } on Exception catch (e) {
        stderr.writeln('Shutdown hook failed: $id | $e');
      }
    }

    stderr.writeln('-- Shutdown completed --');

    final exitCode = isSuccess ? 0 : 1;

    exit(exitCode);
  }
}
