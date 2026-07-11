import 'dart:io';

import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/server/cors_headers.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/server_error_exception.dart';
import 'package:librelab_server/utils/http_status_code.dart';
import 'package:librelab_server/utils/is_debug_mode.dart';
import 'package:librelab_shared/librelab_shared.dart' show ApiDeployment;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
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
  final router = Router();

  final apiRouter = Router(
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

  for (final module in routeModules) {
    apiRouter.mount('/', module.router.call);
  }

  router.mount(ApiDeployment.rootPath, apiRouter.call);

  // The API routes must be registered before the web client hosting route.
  // The web client is mounted at '/' and would otherwise catch API requests.
  if (webClientHostingEnabled) {
    // TODO: Need to automatically download the Flutter web build,
    //  maintain updates, and maybe print the addresses
    _registerWebClientHosting(
      router,
      webDirFileSystemPath: webDirFileSystemPath,
    );
  } else {
    router.get('/', (Request _) {
      return Response.ok('OK');
    });
  }

  final handler = const Pipeline()
      .addMiddleware(_withErrorHandling)
      // This CORS configuration is for development only.
      // It is not production-ready and does not account for
      // authentication or caching.
      // In production, the web app is served from the same origin.
      .when(kDebugMode, (p) => p.addMiddleware(cors(allowedOrigins: null)))
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, address, port);
  server.autoCompress = true;

  return server;
}

void _registerWebClientHosting(
  Router router, {
  required String webDirFileSystemPath,
}) {
  if (Directory(webDirFileSystemPath).existsSync()) {
    router.mount(
      '/',
      createStaticHandler(webDirFileSystemPath, defaultDocument: 'index.html'),
    );
  } else {
    router.get('/', (Request _) {
      return Response.notFound(
        'The directory "$webDirFileSystemPath" was not found.\n'
        'Restart the server after the directory has been created.',
      );
    });
  }
}

Handler _withErrorHandling(Handler innerHandler) {
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

extension on Pipeline {
  Pipeline when(
    // ignore: avoid_positional_boolean_parameters
    @mustBeConst bool condition,
    Pipeline Function(Pipeline) transform,
  ) {
    return condition ? transform(this) : this;
  }
}
