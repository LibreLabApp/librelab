import 'package:http/http.dart' as http;
import 'package:librelab_flutter/common/network/tls_exception/tls_exception.dart';
import 'package:logging/logging.dart';

final class RequestResult<T>({required final T value});

// TODO: Need to add a connection and request timeout to prevent waiting too long
/// Executes [request] against each URI until one succeeds.
///
/// Only connection-related exceptions trigger a fallback to the next URI.
/// HTTP response status codes can be handled by [request].
Future<RequestResult<T>> requestWithFallbackUris<T>({
  required Iterable<Uri Function()> uris,
  required Future<T> Function(Uri uri) request,
  required Logger logger,
}) async {
  Exception? lastException;

  for (final getUri in uris) {
    final uri = getUri();
    try {
      logger.fine('Trying request: $uri');

      final value = await request(uri);

      logger.fine('Request succeeded: $uri');

      return RequestResult(value: value);
    } on http.ClientException catch (e) {
      // Do not pass an exception as an error argument to logger, as it
      // adds noise and may indicate unhandled exceptions when it is
      // expected
      logger.finer('Caught http.ClientException during request: $uri');

      lastException = e;
    } on TlsException catch (e) {
      logger.finer('Caught TlsException during request: $uri', e);
      lastException = e;
    }
  }

  throw lastException ??
      (throw StateError(
        'Invalid state: lastException is null after all attempts. At least one request must fail.',
      ));
}
