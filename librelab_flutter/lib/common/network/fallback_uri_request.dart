import 'package:http/http.dart' as http;
import 'package:librelab_flutter/common/network/tls_exception/tls_exception.dart';

final class RequestResult<T>({required final T value, required final Uri uri});

Future<RequestResult<T>> requestWithFallbackUris<T>({
  required Iterable<Uri> uris,
  required Future<T> Function(Uri uri) request,
}) async {
  Exception? lastException;

  for (final uri in uris) {
    try {
      return RequestResult(value: await request(uri), uri: uri);
    } on http.ClientException catch (e) {
      lastException = e;
    } on TlsException catch (e) {
      lastException = e;
    }
  }

  throw lastException ??
      (throw StateError(
        'Invalid state: lastException is null after all attempts. At least one request must fail.',
      ));
}
