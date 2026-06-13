import 'dart:io';

import 'package:shelf/shelf.dart';

extension RequestExt on Request {
  HttpConnectionInfo? get connectionInfo =>
      context['shelf.io.connection_info'] as HttpConnectionInfo?;

  String? get ipAddress => connectionInfo?.remoteAddress.address;

  String? get userAgent => headers[HttpHeaders.userAgentHeader];
}
