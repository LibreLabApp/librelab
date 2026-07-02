import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/utils/http_status_code.dart';
import 'package:librelab_server/utils/json_types.dart';
import 'package:meta/meta.dart';

/// Exception handled by the server layer and mapped to a [ServerErrorResponse]
/// returned as the HTTP response body.
@immutable
class const ServerErrorException({
  required final HttpStatusCode httpStatus,
  required final String message,
  required final String code,
  final JsonMap? details,
}) implements Exception {
  ServerErrorResponse toResponse() =>
      ServerErrorResponse(message: message, code: code);
}
