# LibreLab API contract package

Shared type-safe client-server API contract that describes HTTP methods,
endpoints, query parameters, headers, and response/request body schemas
for LibreLab.

## Version

[`api_contract_version_constants.dart`](./lib/src/compatibility/api_contract_version_constants.dart)
contains important doc comments about the current and minimum required version.

## Client-server type-safe communication

> [!TIP]
> This is a minimal example of how to add new endpoints to get started.
> It does not follow best practices or the desired or ideal API design.
> It assumes the working directory is the `librelab_api_contract` package.

### Shared DTOs

In this package, define the shared DTOs:

```dart
class CreateBackupRequest({required final bool fullBackup}) {
    // toJson, fromJson methods...
}

class CreateBackupResponse({required final String downloadUrl}) {
    // toJson, fromJson methods...
}
```

### Generate the shared API endpoint definition

Modify [`scripts/endpoint_definition/generate.dart`](./scripts/endpoint_definition/generate.dart) file:

```patch
// Example

final List<ApiNode> _input = [
+  ApiGroup('backup', [
+    HttpEndpoint(.post, 'create')
+  ]),
  ApiGroup('messages', [
    WebSocketEndpoint('listen'),
    HttpEndpoint(.post, 'upload-image'),
  ]),
  ApiGroup('users', [
    ApiGroup(pathParam('userId'), [
      HttpEndpoint(.post, null),
      HttpEndpoint(.get, null),
      HttpEndpoint(.put, null),
      HttpEndpoint(.delete, null),
      ApiGroup('blogs', [HttpEndpoint(.get, pathParam('blogId'))]),
    ]),
  ]),
];

// ...

```

Run the following command in:

```shell
dart scripts/endpoint_definition/generate.dart
```

### Providing the API (server)

```dart
// Dart Shelf server

class BackupRoute {
  Router get router {
    final router = Router();
    
    // register() is an extension function
    router.register(ApiEndpointDefinitions.backup_create$POST, _handler);

    return router;
  }

  Future<Response> _handler(Request request) async {
    final requestBody = await request.readJsonBody(
      fromJson: CreateBackupRequest.fromJson,
    );
    final fullBackup = requestBody.fullBackup;
    
    try {
      final CreateBackupResponse response = ...;
      return response.toJson().httpResponse(.ok); 
    } on Exception catch (e) {
      return ServerErrorResponse(code: 'INTERNAL_SERVER_ERROR', 'Failed to create the backup: ${e.toString()}')
        .toJson().httpResponse(.internalServerError);
    }
  }
}

void main() {
    final app = Router();
    // ...
    app.mount('/', BackupRoute().router.call);
}
```

### Consuming the API (client)

```dart
import 'package:librelab_api_contract/librelab_api_contract.dart' as api;

final ApiClient apiClient;

void main() {
    const endpoint = api.ApiEndpointDefinitions.backup_create$POST;

    final baseUri = Uri.parse(serverBaseUrl);
    final fullUri = baseUri.replace(path: endpoint.path);

    final response = await apiClient.requestJson(
      fullUri,
      method: endpoint.method,
      body: .json(
        const api.CreateBackupRequest(fullBackup: true).toJson(),
      ),
      deserializeSuccess: (response) =>
          api.CreateBackupResponse.fromJson(response.body),
      deserializeFailure: (response) =>
          api.ServerErrorResponse.fromJson(response.body),
    );

    // Map the response...
}
```

> [!IMPORTANT]
> This is a minimal imaginary example and does
> not follow best practices and is inconsistent
> with the codebase. Please consider
> reading an example feature's code.
