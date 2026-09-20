import 'package:librelab_server/audit_log/auditable.dart';
import 'package:librelab_server/utils/json_types.dart';
import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

/// Metadata describing a file stored in the configured storage backend.
///
/// This does not contain the file's bytes. The file is stored separately and
/// can be located using [storageKey].
@immutable
class const StorageObject({
  required final String id,

  /// The key used to locate the stored file in the configured storage backend.
  required final String storageKey,

  /// The original file name provided when the file was stored.
  required final String originalName,
  required final String? mimeType,
  required final int sizeBytes,
  required final String checksumSha256,
  required final StorageObjectPurpose purpose,
  required final DateTime createdAt,
  required final DateTime updatedAt,
}) implements Auditable {
  @override
  JsonMap toAuditJson() => {
    'storageKey': storageKey,
    'originalName': originalName,
    'mimeType': mimeType,
    'sizeBytes': sizeBytes,
    'checksumSha256': checksumSha256,
    'purpose': switch (purpose) {
      .labImage => 'labImage',
    },
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

/// Defines the intended use of a storage object, providing context for
/// determining the permissions required to access or modify it.
enum StorageObjectPurpose { labImage }

@immutable
class const StorageObjectCreate({
  required final String storageKey,
  required final String originalName,
  required final String mimeType,
  required final int sizeBytes,
  required final String checksumSha256,
  required final StorageObjectPurpose purpose,
  required final bool isUpload,
});

@immutable
class const StorageObjectPatch({
  final Field<String> storageKey = const .absent(),
  final Field<String> originalName = const .absent(),
  final Field<String> mimeType = const .absent(),
  final Field<int> sizeBytes = const .absent(),
  final Field<String> checksumSha256 = const .absent(),
});
