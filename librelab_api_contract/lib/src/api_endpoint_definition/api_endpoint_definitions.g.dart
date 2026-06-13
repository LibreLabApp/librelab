// coverage:ignore-file
/// Generated code. Do not modify directly.
/// Instead, modify and then run: dart scripts/endpoint_definition/generate.dart
library;

import 'package:librelab_api_contract/src/api_endpoint_definition/types.dart';

/// Generated code. Do not **modify** directly.
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

  /// HTTP POST /auth/login
  static const HttpEndpoint auth_login$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/auth/login',
  );

  /// HTTP POST /auth/logout
  static const HttpEndpoint auth_logout$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/auth/logout',
  );

  /// HTTP POST /auth/refresh-token
  static const HttpEndpoint auth_refresh_token$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/auth/refresh-token',
  );

  /// HTTP POST /auth/refresh-user
  static const HttpEndpoint auth_refresh_user$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/auth/refresh-user',
  );
}
