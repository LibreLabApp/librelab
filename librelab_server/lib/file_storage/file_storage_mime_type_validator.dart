import 'package:librelab_server/file_storage/storage_object/storage_object.dart';
import 'package:meta/meta.dart';

class FileStorageMimeTypeValidator {
  Set<String> _allowedMimeTypes(StorageObjectPurpose purpose) {
    return switch (purpose) {
      .labImage => const {'image/jpeg', 'image/png', 'image/webp'},
    };
  }

  /// Returns `null` if the MIME type is allowed.
  InvalidStorageMimeType? validate({
    required StorageObjectPurpose purpose,
    required String mimeType,
  }) {
    final allowedMimeTypes = _allowedMimeTypes(purpose);

    if (allowedMimeTypes.contains(mimeType)) {
      return null;
    }

    return .new(allowedMimeTypes: allowedMimeTypes);
  }
}

@immutable
class const InvalidStorageMimeType({
  required final Set<String> allowedMimeTypes,
});
