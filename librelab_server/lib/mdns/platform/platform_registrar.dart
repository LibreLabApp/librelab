import 'dart:async';
import 'dart:io';

import 'package:librelab_server/mdns/service_config.dart';
import 'package:librelab_server/utils/cli_helpers.dart';

abstract interface class MdnsPlatformRegistrar {
  Future<void> start(MdnsServiceConfig config);
  Future<void> stop();
}

/// Base implementation for mDNS implementations backed by a long-running
/// external process.
///
/// [start] launches [executable] asynchronously using [Process.start].
///
/// [stop] attempts graceful shutdown via `SIGTERM`, then force-kills
/// the process with `SIGKILL` if it does not exit within 6 seconds.
///
/// Logging is hardcoded in the implementation.
abstract class ProcessMdnsRegistrar({
  required final String executable,
  required final List<String> Function(MdnsServiceConfig config) buildArguments,
}) implements MdnsPlatformRegistrar {
  Process? _process;

  @override
  Future<void> start(MdnsServiceConfig config) async {
    final process = await executeCommandStream(
      executable,
      buildArguments(config),
    );
    _process = process;

    process.exitCode
        .then((code) {
          final message =
              '[$executable] process exited with code ${humanExitCode(code)}';

          if (code != 0) {
            stderr.writeln(message);
          } else {
            stdout.writeln(message);
          }
        })
        // ignore: unawaited_futures
        .catchError((Object? e) {
          stderr.writeln('[$executable] Failed to read exit code: $e');
        });
  }

  @override
  Future<void> stop() async {
    final process = _process;
    if (process == null) {
      return;
    }

    process.kill(ProcessSignal.sigterm);
    const timeout = Duration(seconds: 6);
    try {
      await process.exitCode.timeout(timeout);
    } on TimeoutException catch (_) {
      process.kill(ProcessSignal.sigkill);

      stdout.writeln(
        '[$executable] Force kill process after ${timeout.inSeconds} seconds',
      );
    } finally {
      _process = null;
    }
  }
}
