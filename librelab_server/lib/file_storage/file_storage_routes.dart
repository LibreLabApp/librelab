import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart'
    show ApiHttpHeaders, ServerErrorResponse, StorageErrorCodes;
import 'package:librelab_api_contract/librelab_api_contract.dart' as api;
import 'package:librelab_server/auth/authorization_service.dart';
import 'package:librelab_server/file_storage/file_storage_authorization_service.dart';
import 'package:librelab_server/file_storage/file_storage_mime_type_validator.dart';
import 'package:librelab_server/file_storage/file_storage_service.dart';
import 'package:librelab_server/file_storage/response_mappers.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object.dart'
    show StorageObject;
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/request_ext.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:librelab_server/utils/json_types.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/shelf_multipart.dart';
import 'package:shelf_router/shelf_router.dart';

class FileStorageRoutes({
  required final AuthorizationService _authorization,
  required final FileStorageAuthorizationService _storageAuthorization,
  required final FileStorageService _storageService,
  required final FileStorageMimeTypeValidator _mimeTypeValidator,
  required final Logger _logger,
}) implements RouteModule {
  @override
  Router get router => .new()
    ..register(
      ApiEndpointDefinitions.storage$GET(id: RouteParams.idPath),
      _getHandler,
    )
    ..register(ApiEndpointDefinitions.storage$POST, _postHandler)
    ..register(
      ApiEndpointDefinitions.storage$PUT(id: RouteParams.idPath),
      _putHandler,
    )
    ..register(
      ApiEndpointDefinitions.storage$DELETE(id: RouteParams.idPath),
      _deleteHandler,
    );

  Future<Response> _getHandler(Request request) =>
      _authorization.withAuthUser(request, (user) async {
        final id = request.idParameter;

        final storageObject = await _storageService.findById(id);

        if (storageObject == null) {
          return _storageObjectNotFoundResponse(id);
        }

        if (_storageAuthorization.authorize(
              purpose: storageObject.purpose,
              operation: .read,
              userAccess: .fromAuthUser(user),
            )
            case final authorizationResponse?) {
          return authorizationResponse;
        }

        try {
          final storedFile = _storageService.open(storageObject);

          if (storedFile == null) {
            return _fileMissingResponse(storageObject);
          }

          return .ok(
            storedFile.content,
            headers: <String, String>{
              ApiHttpHeaders.contentType: ?storageObject.mimeType,
              ApiHttpHeaders.contentLength: storageObject.sizeBytes.toString(),
            },
          );
        } on Exception catch (e, stackTrace) {
          _logger.warning(
            'Storage file could not be opened. '
            'Storage object ID: ${storageObject.id}. '
            'Storage key: ${storageObject.storageKey}.',
            e,
            stackTrace,
          );

          return ServerErrorResponse(
            message: 'The file could not be opened.',
            code: 'FILE_OPEN_FAILED',
            details: {'failureMessage': e.toString()},
          ).toJson().httpResponse(.internalServerError);
        }
      });

  Future<Response> _postHandler(
    Request request,
  ) => _authorization.withAuthUser(request, (user) async {
    final multipartFormData = request.formData();

    if (multipartFormData == null) {
      return _invalidMultipartResponse();
    }

    final multipartData = await _parseMultipartData(multipartFormData);

    if (multipartData.hasMultipleFiles) {
      return _multipleFilesResponse();
    }

    final fileData = multipartData.fileFormData;
    final fileName = fileData?.filename;

    if (fileData == null || fileName == null) {
      return _missingFileResponse();
    }

    final mimeType = fileData.part.headers[ApiHttpHeaders.contentType];
    if (mimeType == null) {
      return _missingMimeTypeResponse();
    }

    final purposeStr = multipartData.purpose;

    if (purposeStr == null) {
      return const ServerErrorResponse(
        message:
            'The storage object purpose is required. Form field: ${api.StorageObjectPurpose.formDataName}',
        code: 'PURPOSE_REQUIRED',
      ).toJson().httpResponse(.badRequest);
    }

    final purposeDto = api.StorageObjectPurpose.fromJson(purposeStr);

    if (purposeDto == null || purposeDto == .unknown) {
      return ServerErrorResponse(
        message:
            'The storage object purpose is invalid. '
            'Valid values: ${api.StorageObjectPurpose.values.where((value) => value != .unknown).map((value) => value.name).join(', ')}',
        code: 'INVALID_PURPOSE',
      ).toJson().httpResponse(.badRequest);
    }

    final purpose = purposeDto.toDomain();

    if (_storageAuthorization.authorize(
          purpose: purpose,
          operation: .create,
          userAccess: .fromAuthUser(user),
        )
        case final authorizationResponse?) {
      return authorizationResponse;
    }

    if (_mimeTypeValidator.validate(purpose: purpose, mimeType: mimeType)
        case final failure?) {
      return _invalidMimeTypeResponse(
        failure,
        mimeType: mimeType,
        purpose: purposeDto.name,
      );
    }

    // TODO: Consider validating the client-provided file extension and actual file content.
    //  MIME type validation is sufficient for now because uploads are restricted
    //  to authenticated LIS users with the required permissions.
    //  If this was updated, the PUT method must be updated as well.

    try {
      final storageObject = await _storageService.create(
        originalName: fileName,
        mimeType: mimeType,
        content: fileData.part,
        purpose: purpose,
        isUpload: true,
        userId: user.id,
        requestMetadata: request.requestMetadata,
      );

      return storageObject.toResponse().toJson().httpResponse(.created);
    } on FileStorageFileTooLargeException catch (e) {
      return _fileTooLargeResponse(
        fileSizeBytes: e.fileSizeBytes,
        maxSizeBytes: e.maxSizeBytes,
      );
    } on Exception catch (e, stackTrace) {
      _logger.warning(
        'The storage object could not be created.',
        e,
        stackTrace,
      );

      return _storageObjectCreateFailedResponse(e);
    }
  });

  Future<Response> _putHandler(
    Request request,
  ) async => _authorization.withAuthUser(request, (user) async {
    final id = request.idParameter;

    final purpose = await _storageService.findPurposeById(id);

    if (purpose == null) {
      return _storageObjectNotFoundResponse(id);
    }

    if (_storageAuthorization.authorize(
          purpose: purpose,
          operation: .update,
          userAccess: .fromAuthUser(user),
        )
        case final authorizationResponse?) {
      return authorizationResponse;
    }

    final multipartFormData = request.formData();

    if (multipartFormData == null) {
      return _invalidMultipartResponse();
    }

    final multipartData = await _parseMultipartData(multipartFormData);

    if (multipartData.hasMultipleFiles) {
      return _multipleFilesResponse();
    }

    final fileData = multipartData.fileFormData;
    final fileName = fileData?.filename;

    if (fileData == null || fileName == null) {
      return _missingFileResponse();
    }

    final mimeType = fileData.part.headers[ApiHttpHeaders.contentType];
    if (mimeType == null) {
      return _missingMimeTypeResponse();
    }

    if (_mimeTypeValidator.validate(purpose: purpose, mimeType: mimeType)
        case final failure?) {
      return _invalidMimeTypeResponse(
        failure,
        mimeType: mimeType,
        purpose: purpose.name,
      );
    }

    if (multipartData.purpose != null) {
      return const ServerErrorResponse(
        message:
            "The '${api.StorageObjectPurpose.formDataName}' field must not be provided when updating a storage object.",
        code: 'PURPOSE_IMMUTABLE',
      ).toJson().httpResponse(.badRequest);
    }

    try {
      final storageObject = await _storageService.update(
        id,
        originalName: fileName,
        mimeType: mimeType,
        content: fileData.part,
        userId: user.id,
        requestMetadata: request.requestMetadata,
      );

      if (storageObject == null) {
        return _storageObjectNotFoundResponse(id);
      }

      return storageObject.toResponse().toJson().httpResponse(.ok);
    } on FileStorageFileTooLargeException catch (e) {
      return _fileTooLargeResponse(
        fileSizeBytes: e.fileSizeBytes,
        maxSizeBytes: e.maxSizeBytes,
      );
    } on Exception catch (e, stackTrace) {
      _logger.warning(
        'The storage object could not be updated. ID: $id.',
        e,
        stackTrace,
      );

      return _storageObjectUpdateFailedResponse(e, id);
    }
  });

  Future<Response> _deleteHandler(Request request) =>
      _authorization.withAuthUser(request, (user) async {
        final id = request.idParameter;

        final purpose = await _storageService.findPurposeById(id);

        if (purpose == null) {
          return _storageObjectNotFoundResponse(id);
        }

        if (_storageAuthorization.authorize(
              purpose: purpose,
              operation: .delete,
              userAccess: .fromAuthUser(user),
            )
            case final authorizationResponse?) {
          return authorizationResponse;
        }

        final deleted = await _storageService.delete(
          id,
          userId: user.id,
          requestMetadata: request.requestMetadata,
        );

        if (!deleted) {
          return _storageObjectNotFoundResponse(id);
        }

        return emptyJson.httpResponse(.ok);
      });

  Future<_MultipartData> _parseMultipartData(
    FormDataRequest multipartFormData,
  ) async {
    String? purpose;

    FormData? fileFormData;
    var hasMultipleFiles = false;

    await for (final data in multipartFormData.formData) {
      final part = data.part;

      if (data.name == api.StorageObjectPurpose.formDataName) {
        purpose = await part.readString();
        continue;
      }

      if (data.filename == null) {
        await part.drain<void>();
        continue;
      }

      if (fileFormData != null) {
        hasMultipleFiles = true;
        await part.drain<void>();
        continue;
      }

      fileFormData = data;
    }

    return .new(
      fileFormData: fileFormData,
      purpose: purpose,
      hasMultipleFiles: hasMultipleFiles,
    );
  }

  Response _storageObjectNotFoundResponse(String id) => ServerErrorResponse(
    message: 'No storage object was found with ID: $id',
    code: StorageErrorCodes.storageObjectNotFound,
  ).toJson().httpResponse(.notFound);

  Response _invalidMultipartResponse() => const ServerErrorResponse(
    message: 'The request body must be multipart/form-data.',
    code: 'INVALID_CONTENT_TYPE',
  ).toJson().httpResponse(.badRequest);

  Response _missingFileResponse() => const ServerErrorResponse(
    message: 'The request must contain a file.',
    code: 'FILE_REQUIRED',
  ).toJson().httpResponse(.badRequest);

  Response _multipleFilesResponse() => const ServerErrorResponse(
    message: 'The request must contain exactly one file.',
    code: 'MULTIPLE_FILES',
  ).toJson().httpResponse(.badRequest);

  Response _fileMissingResponse(StorageObject object) => ServerErrorResponse(
    message:
        'The file associated with storage object ID ${object.id} could not be found. '
        'Storage key: ${object.storageKey}',
    code: StorageErrorCodes.fileMissing,
  ).toJson().httpResponse(.notFound);

  Response _fileTooLargeResponse({
    required int fileSizeBytes,
    required int maxSizeBytes,
  }) => ServerErrorResponse(
    message:
        'The uploaded file size of $fileSizeBytes bytes exceeds the maximum allowed size of $maxSizeBytes bytes.',
    code: StorageErrorCodes.fileToolLarge,
    details: {'fileSizeBytes': fileSizeBytes, 'maxSizeBytes': maxSizeBytes},
  ).toJson().httpResponse(.contentTooLarge);

  Response _missingMimeTypeResponse() => const ServerErrorResponse(
    message: 'The uploaded file must have a MIME type.',
    code: 'MIME_TYPE_REQUIRED',
  ).toJson().httpResponse(.badRequest);

  Response _storageObjectCreateFailedResponse(Exception e) =>
      ServerErrorResponse(
        message: 'The storage object could not be created.',
        code: 'STORAGE_OBJECT_CREATE_FAILED',
        details: {'failureMessage': e.toString()},
      ).toJson().httpResponse(.internalServerError);

  Response _storageObjectUpdateFailedResponse(Exception e, String id) =>
      ServerErrorResponse(
        message: 'The storage object could not be updated: $id',
        code: 'STORAGE_OBJECT_UPDATED_FAILED',
        details: {'failureMessage': e.toString()},
      ).toJson().httpResponse(.internalServerError);

  Response _invalidMimeTypeResponse(
    InvalidStorageMimeType failure, {
    required String mimeType,
    required String purpose,
  }) => ServerErrorResponse(
    message:
        'The MIME type "$mimeType" is not allowed for this purpose: "$purpose". '
        'Allowed MIME types: ${failure.allowedMimeTypes.join(', ')}.',
    code: 'INVALID_MIME_TYPE',
  ).toJson().httpResponse(.badRequest);
}

@immutable
class const _MultipartData({
  required final FormData? fileFormData,
  required final String? purpose,
  required final bool hasMultipleFiles,
});
