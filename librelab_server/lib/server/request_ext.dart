import 'dart:io' show HttpConnectionInfo;

import 'package:librelab_api_contract/librelab_api_contract.dart'
    show ApiHttpHeaders;
import 'package:librelab_server/audit_log/audit_log.dart';
import 'package:librelab_server/utils/validation/id_validation.dart';
import 'package:shelf/shelf.dart' show Request;
import 'package:shelf_router/shelf_router.dart' show Router, RouterParams;

extension RequestExt on Request {
  /// May be `null` if the Shelf server implementation is not `shelf_io`.
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
  String get _rawIdParameter =>
      params[RouteParams._id] ??
      (throw StateError('Missing URL parameter: ${RouteParams._id}'));

  /// The `id` URL parameter captured by [Router], validated as a UUID.
  ///
  /// Throws [InvalidUuidException] if the parameter is not a valid UUID.
  ///
  /// See also: [_rawIdParameter]
  String get idParameter {
    final id = _rawIdParameter;
    validateId(id);
    return id;
  }
}

abstract final class RouteParams {
  static const _id = 'id';

  /// The Shelf route pattern for the [_id] parameter.
  static const idPath = '<$_id>';
}
