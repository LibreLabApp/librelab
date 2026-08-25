import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_schema.g.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object_repository.dart';

typedef _T = StorageObjectsTable;
typedef _Row = StorageObjectsRow;

class StorageObjectRepositoryPostgres(final SqlDatabaseAccess _db)
    implements StorageObjectRepository {
  @override
  Future<StorageObject?> findById(String id) async {
    final result = await _db.execute(
      '''
SELECT * FROM ${_T.tableName}
WHERE ${_T.id} = @id
''',
      parameters: {'id': id},
    );
    final row = result.firstOrNull;
    if (row == null) {
      return null;
    }

    final map = row.toColumnMap();

    return _Row.fromMap(map).toDomain();
  }

  @override
  Future<StorageObject> create(StorageObjectCreate create) async {
    final Map<String, Object> params = _T.insert(
      storageKey: create.storageKey,
      originalName: create.originalName,
      mimeType: create.mimeType,
      sizeBytes: create.sizeBytes,
      checksumSha256: create.checksumSha256,
    );
    final result = await _db.execute('''
INSERT INTO ${_T.tableName}
(${params.keys.join(', ')})
VALUES (${params.keys.map((key) => '@$key').join(', ')})
RETURNING *
''', parameters: params);

    return _Row.fromMap(result.first.toColumnMap()).toDomain();
  }

  @override
  Future<bool> delete(String id) async {
    final result = await _db.execute(
      '''
DELETE FROM ${_T.tableName}
WHERE ${_T.id} = @id
RETURNING ${_T.id}
''',
      parameters: {'id': id},
    );
    return result.isNotEmpty;
  }

  // TODO: Handle empty patches consistently across all repository update methods.
  //  Proposal: `throw ArgumentError('At least one field must be present.')` in
  //  the generated code.
  @override
  Future<StorageObject?> update(String id, StorageObjectPatch patch) async {
    final Map<String, Object?> params = _T.update(
      storageKey: patch.storageKey,
      originalName: patch.originalName,
      mimeType: patch.mimeType,
      sizeBytes: patch.sizeBytes,
      checksumSha256: patch.checksumSha256,
    );

    final result = await _db.execute(
      '''
UPDATE ${_T.tableName}
SET ${params.keys.map((key) => '$key = @$key').join(', ')}
WHERE ${_T.id} = @id
RETURNING *
''',
      parameters: {'id': id, ...params},
    );
    if (result.isEmpty) {
      return null;
    }

    final row = result.firstOrNull;
    if (row == null) {
      return null;
    }

    final map = row.toColumnMap();

    return _Row.fromMap(map).toDomain();
  }
}

extension on _Row {
  StorageObject toDomain() {
    return .new(
      id: id,
      storageKey: storageKey,
      originalName: originalName,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      checksumSha256: checksumSha256,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
