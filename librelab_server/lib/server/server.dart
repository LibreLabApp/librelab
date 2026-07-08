import 'dart:io';

import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/server/cors_headers.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/server_error_exception.dart';
import 'package:librelab_server/utils/http_status_code.dart';
import 'package:librelab_server/utils/is_debug_mode.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

final _logger = Logger('Server');

Future<HttpServer> startServer({
  required int port,
  required String address,
  required List<RouteModule> routeModules,
  required bool webClientHostingEnabled,
  required String webDirFileSystemPath,
}) async {
  final router = Router(
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

  router.get('/', (Request _) {
    return Response.ok('OK');
  });

  for (final module in routeModules) {
    router.mount('/', module.router.call);
  }

  final handler = const Pipeline()
      .addMiddleware(withErrorHandling)
      // TODO: Current cors() implementation is not production-ready and does not
      //  take into account authentication, caching, different origins (needs careful review).
      //  Find a reliable solution in production mode for the web
      //  or remove in non-debug builds
      .addMiddleware(cors(allowedOrigins: kDebugMode ? null : {}))
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, address, port);
  server.autoCompress = true;

  if (webClientHostingEnabled) {
    // TODO: Need to automatically download the web app build,
    //  maintain updates, and maybe print the addresses
    if (Directory(webDirFileSystemPath).existsSync()) {
      router.mount(
        '/web/',
        createStaticHandler(
          webDirFileSystemPath,
          defaultDocument: 'index.html',
        ),
      );
    } else {
      router.get('/web/', (Request req) {
        return Response.notFound(
          'The directory "$webDirFileSystemPath" was not found.\n'
          'Restart the server after the directory has been created.',
        );
      });
    }
  }

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
      // Typically, Dart errors should be addressed and not handled at runtime.
      // However, returning 500 (structured response) and logging it is
      // better than silently crashing or delegating to the
      // Dart shelf default handler.
      // ignore: avoid_catches_without_on_clauses
    } catch (e, stackTrace) {
      _logger.shout(
        'Unhandled Dart error in request handler (most likely a programming BUG!)',
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
    InvalidJsonRequestBodyException(:final message) => (
      ServerErrorResponse(
        code: 'MALFORMED_JSON',
        message: 'Malformed or unparsable JSON payload.',
        details: kDebugMode ? {'debug': message} : null,
      ),
      .badRequest,
    ),
    InvalidJsonRequestBodySchemaException(:final message) => (
      ServerErrorResponse(
        code: 'JSON_SCHEMA_MISMATCH',
        message: 'Payload schema mismatch. A client update may be required.',
        details: kDebugMode ? {'debug': message} : null,
      ),
      .badRequest,
    ),
    ServerErrorException(:final httpStatus) => (e.toResponse(), httpStatus),
    Exception() => (
      ServerErrorResponse(
        message: 'INTERNAL_SERVER_ERROR',
        code: 'Unhandled server error',
        details: kDebugMode ? {'debug': e.toString()} : null,
      ),
      .internalServerError,
    ),
  };

  return errorResponse.toJson().httpResponse(statusCode);
}
