import 'dart:io';

import 'package:logging/logging.dart';

Future<Duration?> measureLatency({
  required String host,
  required int port,
  Duration timeout = const Duration(seconds: 1),
  Logger? logger,
}) async {
  final stopwatch = Stopwatch()..start();

  try {
    final socket = await Socket.connect(host, port, timeout: timeout);
    stopwatch.stop();

    await socket.close();

    return stopwatch.elapsed;
  } on Exception catch (e) {
    logger?.fine('TCP latency measurement failed for "$host:$port"', e);
    return null;
  } finally {
    stopwatch.stop();
  }
}
