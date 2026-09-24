import 'package:librelab_server/auth/authorization_service.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object.dart';
import 'package:librelab_server/user/role/role.dart';
import 'package:librelab_server/user/user_access.dart';
import 'package:shelf/shelf.dart';

/// Authorizes file storage operations based on their purpose.
class FileStorageAuthorizationService({
  required final AuthorizationService _authorization,
}) {
  // TODO: (Not specific to this class, this is an example)
  //  Review methods that return HTTP responses directly and consider a better
  //  separation of concerns, such as throwing transport-agnostic exceptions and
  //  handling them in the global server handler.
  //  - Includes methods that return non-nullable `Response`, such as
  //    `AuthorizationService.withFullUser`.
  //  - Includes methods that return nullable `Response`, such as
  //    `StorageAuthorizationService.authorize`.

  /// Authorizes access to a storage object based on its purpose and operation.
  ///
  /// Returns `null` if the operation is authorized. Otherwise, returns the
  /// [Response] that should be returned to the client.
  Response? authorize({
    required StorageObjectPurpose purpose,
    required StorageOperation operation,
    required UserAccess userAccess,
  }) {
    final Permission? permission = switch ((operation, purpose)) {
      (.read, .labImage) => null,
      (.create, .labImage) => .labSettingsUpdate,
      (.update, .labImage) => .labSettingsUpdate,
      (.delete, .labImage) => .labSettingsUpdate,
    };

    if (permission == null) {
      return null;
    }

    return _authorization.checkPermission(permission, userAccess: userAccess);
  }
}

enum StorageOperation { read, create, update, delete }
