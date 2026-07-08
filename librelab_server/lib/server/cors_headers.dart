import 'package:librelab_server/utils/http_status_code.dart';
import 'package:shelf/shelf.dart';

/// CORS middleware for handling cross-origin browser requests.
///
/// Handles preflight (`OPTIONS`) requests and adds required CORS headers
/// to normal responses.
///
/// Requests without an `Origin` header skip CORS handling (i.e., non-browser clients).
///
/// Set [allowedOrigins] to `null` to allow all origins.
Middleware cors({required Set<String>? allowedOrigins}) {
  return (Handler inner) {
    return (Request request) async {
      final origin = request.headers['origin'];

      if (origin == null) {
        // Non-web client
        return inner(request);
      }

      final allowOrigin =
          allowedOrigins == null || allowedOrigins.contains(origin);

      if (request.method == 'OPTIONS') {
        return Response(
          HttpStatusCode.noContent.value,
          headers: <String, String>{
            if (allowOrigin) 'Access-Control-Allow-Origin': origin,
            'Access-Control-Allow-Methods':
                'GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
          },
        );
      }

      final response = await inner(request);

      // Avoid spreading `response.headers` into `response.change(headers: ...)`.
      // The flattened headers map cannot preserve multiple `Set-Cookie` headers,
      // causing them to be collapsed into a single comma-separated header.
      // https://github.com/dart-lang/shelf/issues/521#issuecomment-4918308266
      return response.change(
        headers: {if (allowOrigin) 'Access-Control-Allow-Origin': origin},
      );
    };
  };
}
