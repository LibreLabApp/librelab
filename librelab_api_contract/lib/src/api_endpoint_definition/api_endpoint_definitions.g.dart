// coverage:ignore-file
// ignore_for_file: constant_identifier_names
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
  /// HTTP POST /compatibility/check
  static const HttpEndpoint compatibility_check$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/compatibility/check',
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

  /// HTTP POST /auth/refresh
  static const HttpEndpoint auth_refresh$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/auth/refresh',
  );

  /// HTTP POST /auth/browser/login
  static const HttpEndpoint auth_browser_login$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/auth/browser/login',
  );

  /// HTTP POST /auth/browser/logout
  static const HttpEndpoint auth_browser_logout$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/auth/browser/logout',
  );

  /// HTTP POST /auth/browser/refresh
  static const HttpEndpoint auth_browser_refresh$POST = HttpEndpoint(
    method: HttpMethod.post,
    path: '/auth/browser/refresh',
  );

  /// HTTP GET /users/me
  static const HttpEndpoint users_me$GET = HttpEndpoint(
    method: HttpMethod.get,
    path: '/users/me',
  );

  /// HTTP PATCH /lab-settings
  static const HttpEndpoint lab_settings$PATCH = HttpEndpoint(
    method: HttpMethod.patch,
    path: '/lab-settings',
  );

  /// HTTP GET /lab-settings
  static const HttpEndpoint lab_settings$GET = HttpEndpoint(
    method: HttpMethod.get,
    path: '/lab-settings',
  );
}
