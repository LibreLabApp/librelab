import 'package:librelab_server/file_storage/storage_object/storage_object.dart';

/// Provides persistence for [StorageObject] (the file metadata).
///
/// This repository does not access or manage the stored file's bytes.
abstract interface class StorageObjectRepository {
  Future<StorageObject?> findById(String id);

  /// Creates a new storage object.
  /// [StorageObjectCreate.storageKey] must be unique.
  Future<StorageObject> create(StorageObjectCreate create);

  /// Returns whether the storage object was deleted.
  /// `false` if the storage object does not exist.
  Future<bool> delete(String id);

  /// Returns the updated storage object or `null` if the storage object
  /// does not exist.
  Future<StorageObject?> update(String id, StorageObjectPatch patch);
}
