import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

Future<Duration?> measureHttpLatency(
  Uri url, {
  Duration timeout = const Duration(seconds: 1),
  Logger? logger,
  required http.Client client,
}) async {
  final stopwatch = Stopwatch();

  try {
    stopwatch.start();
    await client.head(url).timeout(timeout);
    stopwatch.stop();
    return stopwatch.elapsed;
  } on Exception catch (e) {
    logger?.fine('TCP latency measurement failed for $url', e);
    return null;
  }
}
