import 'package:api_client/api_client.dart' show MultipartFile;
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';

class FileStorageEndpoints(final LibreLabApiClient _client) {
  Future<LibreLabApiResult<StorageObject>> upload({
    required MultipartFile file,
    required StorageObjectPurpose purpose,
  }) {
    if (purpose == .unknown) {
      throw ArgumentError.value(
        purpose,
        'purpose',
        'cannot be ${purpose.name}',
      );
    }
    return _client.requestAuthenticated(
      ApiEndpointDefinitions.storage$POST,
      body: .multipart(
        .new(
          fields: {StorageObjectPurpose.formDataName: purpose.toJson()},
          files: [file],
        ),
      ),
      deserializeSuccess: (response) => .fromJson(response.body),
    );
  }

  Future<LibreLabApiResult<void>> delete(String id) async =>
      _client.requestAuthenticated(
        ApiEndpointDefinitions.storage$DELETE(id: id),
        deserializeSuccess: (_) => {},
      );

  Future<LibreLabApiResult<StorageObject>> update({
    required String id,
    required MultipartFile file,
  }) async => _client.requestAuthenticated(
    ApiEndpointDefinitions.storage$PUT(id: id),
    body: .multipart(.new(fields: {}, files: [file])),
    deserializeSuccess: (response) => .fromJson(response.body),
  );

  // Returns the URL for accessing the file content of the storage object
  /// identified by [storageObjectId].
  Uri url(String storageObjectId) => _client.endpointUrl(
    ApiEndpointDefinitions.storage$GET(id: storageObjectId),
  );

  // TODO: Implement GET when a streamed file response is needed (e.g., for
  //  downloading backup files). This requires adding streamed request support to
  //  both [LibreLabApiClient] and [HttpApiClient].
  //  A starting point:
  //
  // Future<...<Stream<List<int>>>> get(String id) async =>
  //     _client.requestAuthenticatedStreamed(
  //       ApiEndpointDefinitions.storage$GET(id: id),
  //     );
}
