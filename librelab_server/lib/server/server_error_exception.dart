import 'package:json_utils/json_utils.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/utils/http_status_code.dart';
import 'package:meta/meta.dart';

/// Exception handled by the server layer and mapped to a [ServerErrorResponse]
/// returned as the HTTP response body.
@immutable
class ServerErrorException implements Exception {
  const ServerErrorException({
    required this.httpStatus,
    required this.message,
    required this.code,
    this.details,
  });

  final HttpStatusCode httpStatus;
  final String message;
  final String code;
  final JsonMap? details;

  ServerErrorResponse toResponse() =>
      ServerErrorResponse(message: message, code: code);
}
