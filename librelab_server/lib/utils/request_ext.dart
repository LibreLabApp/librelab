import 'dart:io' show HttpConnectionInfo, HttpHeaders;

import 'package:shelf/shelf.dart';

extension RequestExt on Request {
  /// Assumes shelf_io implementation
  HttpConnectionInfo? get connectionInfo =>
      context['shelf.io.connection_info'] as HttpConnectionInfo?;

  String? get ipAddress => connectionInfo?.remoteAddress.address;

  String? get userAgent => headers[HttpHeaders.userAgentHeader];

  String? extractBearerToken() {
    final header = headers[HttpHeaders.authorizationHeader];
    if (header == null) {
      return null;
    }
    const prefix = 'Bearer ';
    if (!header.startsWith(prefix)) {
      return null;
    }
    final token = header.substring(prefix.length).trim();
    return token;
  }
}
