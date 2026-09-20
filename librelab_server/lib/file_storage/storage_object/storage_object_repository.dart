import 'package:librelab_server/database/sql_executor/sql_executor.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object.dart';

/// Provides persistence for [StorageObject] (the file metadata).
///
/// This repository does not access or manage the stored file's bytes.
abstract interface class StorageObjectRepository {
  /// Finds a storage object by its ID.
  ///
  /// Returns `null` if the storage object does not exist.
  Future<StorageObject?> findById(String id);

  /// Finds the purpose of a storage object by its ID.
  ///
  /// Returns `null` if the storage object does not exist.
  Future<StorageObjectPurpose?> findPurposeById(String id);

  /// Creates a new storage object.
  /// [StorageObjectCreate.storageKey] must be unique.
  Future<StorageObject> create(
    StorageObjectCreate create, {
    SqlExecutor? executor,
  });

  /// Deletes a storage object.
  ///
  /// Returns the deleted storage object, or `null` if the storage object
  /// does not exist.
  Future<StorageObject?> delete(String id, {SqlExecutor? executor});

  /// Returns the updated storage object or `null` if the storage object
  /// does not exist.
  Future<StorageObject?> update(
    String id,
    StorageObjectPatch patch, {
    SqlExecutor? executor,
  });
}
