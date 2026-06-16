import 'dart:io' show HttpConnectionInfo;

import 'package:librelab_api_contract/librelab_api_contract.dart'
    show ApiHttpHeaders;
import 'package:shelf/shelf.dart';

extension RequestExt on Request {
  /// May be null if the implementation is not `shelf_io`.
  HttpConnectionInfo? get connectionInfo =>
      context['shelf.io.connection_info'] as HttpConnectionInfo?;

  String? get ipAddress => connectionInfo?.remoteAddress.address;

  String? get userAgent => headers[ApiHttpHeaders.userAgent];

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
}
