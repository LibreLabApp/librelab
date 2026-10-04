import 'package:api_client/api_client.dart' show MediaType, MultipartFile;
import 'package:librelab_api_client/librelab_api_client.dart'
    show FileStorageEndpoints;
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:meta/meta.dart';

@immutable
class const FileUpload({
  /// The stream that will emit the file's contents.
  required final Stream<List<int>> stream,

  /// The size of the file in bytes.
  required final int length,

  /// The basename of the file.
  required final String filename,

  /// The MIME type of the file.
  required final String mimeType,
});

@immutable
class const FileDownload({
  /// The stream that emits the file's contents.
  required final Stream<List<int>> stream,

  /// The size of the file in bytes.
  required final int? length,
});

enum StorageObjectPurpose {
  labImage,

  /// The server sent an enum that this client does not recognize.
  unknown,
}

// TODO: Handle all relevant StorageErrorCodes cases

class FileStorageRepository({
  required final FileStorageEndpoints _fileStorageEndpoints,
  required final ApiRequestHandler _handler,
}) {
  FileStorageEndpoints get _endpoints => _fileStorageEndpoints;

  /// Returns the file content of the storage object identified by [id] as a
  /// stream of bytes.
  Future<ApiRequestResult<FileDownload>> get(String id) => _handler.execute(
    () => _endpoints.get(id),
    mapSuccess: (response) =>
        .new(stream: response.body, length: response.contentLength),
  );

  /// Uploads [file] with the specified [purpose] and returns the ID of the
  /// newly created storage object.
  Future<ApiRequestResult<String>> upload({
    required FileUpload file,
    required StorageObjectPurpose purpose,
  }) => _handler.execute(
    () => _endpoints.upload(
      file: _toMultipartFile(file),
      purpose: switch (purpose) {
        .labImage => .labImage,
        .unknown => throw ArgumentError.value(
          purpose,
          'purpose',
          'cannot be ${purpose.name}',
        ),
      },
    ),
    mapSuccess: (response) => response.body.id,
  );

  Future<ApiRequestResult<void>> update({
    required String id,
    required FileUpload file,
  }) async => _handler.execute(
    () => _endpoints.update(id: id, file: _toMultipartFile(file)),
    mapSuccess: (_) {},
  );

  Future<ApiRequestResult<void>> delete(String id) async =>
      _handler.execute(() => _endpoints.delete(id), mapSuccess: (_) {});

  MultipartFile _toMultipartFile(FileUpload file) => .new(
    'file',
    file.stream,
    file.length,
    filename: file.filename,
    contentType: MediaType.parse(file.mimeType),
  );
}
