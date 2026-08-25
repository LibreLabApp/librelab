import 'dart:io' show HttpConnectionInfo;

import 'package:librelab_api_contract/librelab_api_contract.dart'
    show ApiHttpHeaders;
import 'package:librelab_server/audit_log/audit_log.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' show Router, RouterParams;

extension RequestExt on Request {
  /// May be null if the implementation is not `shelf_io`.
  HttpConnectionInfo? get connectionInfo =>
      context['shelf.io.connection_info'] as HttpConnectionInfo?;

  String? get ipAddress => connectionInfo?.remoteAddress.address;
  String? get userAgent => headers[ApiHttpHeaders.userAgent];
  RequestMetadata get requestMetadata =>
      .new(ipAddress: ipAddress, userAgent: userAgent);

  String? extractBearerToken() {
    final header = headers[ApiHttpHeaders.authorization];
    if (header == null) {
      return null;
    }
    const prefix = ApiHttpHeaders.bearerPrefix;
    if (!header.startsWith(prefix)) {
      return null;
    }
    final token = header.substring(prefix.length).trim();
    return token;
  }

  /// The `id` URL parameter captured by [Router].
  ///
  /// Throws [StateError] if the route does not define an `id` parameter.
  String get idParameter =>
      params['id'] ?? (throw StateError('Missing URL parameter: id'));
}
