// coverage:ignore-file
/// Generated code. Do not modify directly.
/// Instead, modify and then run: dart scripts/endpoint_definition/generate.dart
library;

import 'package:librelab_api_contract/src/api_endpoint_definition/types.dart';

/// Generated code. Do not modify directly.
///
/// Shared type-safe definition of client-server endpoints (HTTP or WebSocket).
/// Each endpoint includes URL path and/or HTTP method (if endpoint is HTTP).
///
/// The server exposes/implements the API, and the API client consumes it.
/// This contract does not include request/response schemas, headers, or other metadata.
abstract final class ApiEndpointDefinitions {
  /// HTTP POST /handshake
  static const HttpEndpoint handshake$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/handshake',
  );

  /// HTTP POST /users
  static const HttpEndpoint users$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/users',
  );

  /// HTTP PUT /users
  static const HttpEndpoint users$PUT = HttpEndpoint(
    method: HttpMethod.put,
    path: '/users',
  );

  /// HTTP GET /users
  static const HttpEndpoint users$GET = HttpEndpoint(
    method: HttpMethod.get,
    path: '/users',
  );

  /// HTTP DELETE /users
  static const HttpEndpoint users$DELETE = HttpEndpoint(
    method: HttpMethod.delete,
    path: '/users',
  );
}
