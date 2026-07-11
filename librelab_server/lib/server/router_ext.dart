import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:shelf_router/shelf_router.dart';

extension RouterExt on Router {
  void register(EndpointDefinition endpoint, Function handler) {
    final normalizedPath = endpoint.normalizedPath;

    switch (endpoint) {
      case HttpEndpoint(:final method):
        switch (method) {
          case .get:
            get(normalizedPath, handler);
          case .head:
            head(normalizedPath, handler);
          case .post:
            post(normalizedPath, handler);
          case .put:
            put(normalizedPath, handler);
          case .patch:
            patch(normalizedPath, handler);
          case .delete:
            delete(normalizedPath, handler);
        }

      case WebSocketEndpoint():
        get(normalizedPath, handler);
    }
  }
}

extension on EndpointDefinition {
  String get normalizedPath {
    if (path.startsWith('/')) {
      throw ArgumentError.value(
        path,
        'endpointPath',
        'must not start with "/"',
      );
    }
    return '/$path';
  }
}
