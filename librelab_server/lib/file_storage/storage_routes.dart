import 'dart:io';

import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/auth/authorization_service.dart';
import 'package:librelab_server/file_storage/file_storage_service.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/request_ext.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid_value.dart';

class StorageRoutes({
  required final AuthorizationService _authorization,
  required final FileStorageService _fileStorageService,
}) implements RouteModule {
  @override
  Router get router => .new()
    ..register(ApiEndpointDefinitions.storage$GET(id: '<id>'), _getFileHandler)
    ..register(
      ApiEndpointDefinitions.storage$DELETE(id: '<id>'),
      _deleteStorageHandler,
    );

  // TODO: Implement patch and post

  Future<Response> _getFileHandler(Request request) =>
      _authorization.withAuthUser(request, (_) async {
        final id = request.idParameter;

        final invalidIdResponse = _validateId(id);
        if (invalidIdResponse != null) {
          return invalidIdResponse;
        }

        final storedFile = await _fileStorageService.open(id);

        if (storedFile == null) {
          return _fileNotFoundResponse(id);
        }

        final storageObject = storedFile.storageObject;

        return .ok(
          storedFile.content,
          headers: <String, String>{
            HttpHeaders.contentTypeHeader: ?storageObject.mimeType,
            HttpHeaders.contentLengthHeader: storageObject.sizeBytes.toString(),
          },
        );
      });

  Future<Response> _deleteStorageHandler(Request request) =>
      _authorization.withAuthUser(request, (_) async {
        final id = request.idParameter;

        final invalidIdResponse = _validateId(id);
        if (invalidIdResponse != null) {
          return invalidIdResponse;
        }

        final deleted = await _fileStorageService.delete(id);

        if (!deleted) {
          return _fileNotFoundResponse(id);
        }

        return <String, Object?>{}.httpResponse(.ok);
      });

  bool _isValidUuid(String value) {
    try {
      UuidValue.withFormatValidation(value);
      return true;
    } on FormatException {
      return false;
    }
  }

  // Validate the UUID before passing it to the service using this method.
  // An invalid UUID would otherwise cause an unhandled database exception.
  Response? _validateId(String id) {
    if (_isValidUuid(id)) {
      return null;
    }

    return ServerErrorResponse(
      message: 'The provided file ID is not a valid UUID: $id',
      code: 'INVALID_UUID',
    ).toJson().httpResponse(.badRequest);
  }

  Response _fileNotFoundResponse(String id) => ServerErrorResponse(
    message: 'No file was found with ID: $id',
    code: 'FILE_NOT_FOUND',
  ).toJson().httpResponse(.notFound);
}
