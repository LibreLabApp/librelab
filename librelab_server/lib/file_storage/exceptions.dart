import 'package:librelab_server/file_storage/storage_object/storage_object.dart'
    show StorageObjectPurpose;

final class const StorageObjectNotFoundException(final String id)
    implements Exception {
  @override
  String toString() => 'Storage object not found: $id';
}

final class const InvalidStorageObjectPurposeException({
  required final String id,
  required final StorageObjectPurpose expected,
  required final StorageObjectPurpose actual,
}) implements Exception {
  @override
  String toString() =>
      'Storage object $id has purpose $actual, expected $expected';
}
