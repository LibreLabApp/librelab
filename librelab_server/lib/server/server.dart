import 'dart:io';

import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/server_error_exception.dart';
import 'package:librelab_server/utils/http_status_code.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

final _logger = Logger('Server');

Future<HttpServer> startServer({
  required int port,
  required String address,
  required List<RouteModule> routeModules,
}) async {
  final app = Router(
    notFoundHandler: (request) => ServerErrorResponse(
      message: 'Route not found',
      code: 'NOT_FOUND',
      details: {
        'url': request.url.toString(),
        'requestUri': request.requestedUri.toString(),
        'method': request.method,
      },
    ).toJson().httpResponse(.notFound),
  );

  app.get('/', (Request _) {
    return Response.ok('OK');
  });

  for (final module in routeModules) {
    app.mount('/', module.router.call);
  }

  final handler = const Pipeline()
      .addMiddleware(withErrorHandling)
      .addHandler(app.call);

  final server = await shelf_io.serve(handler, address, port);
  server.autoCompress = true;

  return server;
}

Handler withErrorHandling(Handler innerHandler) {
  return (Request request) async {
    try {
      return await innerHandler(request);
    } on ServerErrorException catch (e) {
      return _mapException(e);
    } on InvalidJsonRequestBodyException catch (e) {
      return _mapException(e);
    } on InvalidJsonRequestBodySchemaException catch (e) {
      return _mapException(e);
    } on Exception catch (e, stackTrace) {
      _logger.warning('Unhandled exception in request handler', e, stackTrace);

      return _mapException(e);
      // Typically, we should not handle Dart errors this. However, returning 500
      // (structured response), and logging it is better than silently
      // crash or delegate to the Dart shelf default handler.
      // ignore: avoid_catches_without_on_clauses
    } catch (e, stackTrace) {
      _logger.shout(
        'Unhandled Dart error in request handler (most likely a programming bug!)',
        e,
        stackTrace,
      );

      return const ServerErrorResponse(
        message: 'INTERNAL_SERVER_BUG',
        code: 'Caught an unknown internal programming bug on the server!',
      ).toJson().httpResponse(.internalServerError);
    }
  };
}

Response _mapException(Exception e) {
  final (
    ServerErrorResponse errorResponse,
    HttpStatusCode statusCode,
  ) = switch (e) {
    InvalidJsonRequestBodyException() => (
      const ServerErrorResponse(
        code: 'MALFORMED_JSON',
        message: 'Malformed or unparsable JSON payload.',
      ),
      .badRequest,
    ),
    InvalidJsonRequestBodySchemaException() => (
      const ServerErrorResponse(
        code: 'JSON_SCHEMA_MISMATCH',
        message: 'Payload schema mismatch. A client update may be required.',
      ),
      .badRequest,
    ),
    ServerErrorException(:final httpStatus) => (e.toResponse(), httpStatus),
    Exception() => (
      const ServerErrorResponse(
        message: 'INTERNAL_SERVER_ERROR',
        code: 'Unhandled server error',
      ),
      .internalServerError,
    ),
  };

  return errorResponse.toJson().httpResponse(statusCode);
}
