import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:shelf_router/shelf_router.dart';

extension RouterExt on Router {
  void register(EndpointDefinition endpoint, Function handler) {
    switch (endpoint) {
      case HttpEndpoint(:final method, :final path):
        switch (method) {
          case .get:
            get(path, handler);
          case .head:
            head(path, handler);
          case .post:
            post(path, handler);
          case .put:
            put(path, handler);
          case .patch:
            patch(path, handler);
          case .delete:
            delete(path, handler);
        }
      case WebSocketEndpoint(:final path):
        get(path, handler);
    }
  }
}
