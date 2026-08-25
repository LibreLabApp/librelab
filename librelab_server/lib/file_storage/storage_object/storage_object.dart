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
  required final DateTime createdAt,
  required final DateTime updatedAt,
});

@immutable
class const StorageObjectCreate({
  required final String storageKey,
  required final String originalName,
  required final String? mimeType,
  required final int sizeBytes,
  required final String checksumSha256,
});

@immutable
class const StorageObjectPatch({
  final Field<String> storageKey = const .absent(),
  final Field<String> originalName = const .absent(),
  final Field<String?> mimeType = const .absent(),
  final Field<int> sizeBytes = const .absent(),
  final Field<String> checksumSha256 = const .absent(),
});
