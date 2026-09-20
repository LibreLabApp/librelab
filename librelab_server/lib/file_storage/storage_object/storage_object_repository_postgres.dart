import 'package:librelab_server/database/database_schema.g.dart';
import 'package:librelab_server/database/sql_executor/sql_executor.dart';
import 'package:librelab_server/database/sql_executor/sql_repository.dart';
import 'package:librelab_server/database/utils/postgresql_utils.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object_repository.dart';

typedef _T = StorageObjectsTable;
typedef _Row = StorageObjectsRow;

final class StorageObjectRepositoryPostgres(super.db)
    extends SqlRepository
    implements StorageObjectRepository {
  @override
  Future<StorageObject?> findById(String id) async {
    final result = await db.execute(
      '''
SELECT $_selectColumns FROM ${_T.tableName}
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
  Future<StorageObjectPurpose?> findPurposeById(String id) async {
    final result = await db.execute(
      '''
SELECT ${castColumnToText(_T.purpose)} FROM ${_T.tableName}
WHERE ${_T.id} = @id
''',
      parameters: {'id': id},
    );
    final row = result.firstOrNull;
    if (row == null) {
      return null;
    }

    final purpose = row.first! as String;

    return StorageObjectPurposePgEnum.fromText(purpose).toDomain();
  }

  @override
  Future<StorageObject> create(
    StorageObjectCreate create, {
    SqlExecutor? executor,
  }) async {
    final Map<String, Object> params = _T.insert(
      storageKey: create.storageKey,
      originalName: create.originalName,
      mimeType: create.mimeType,
      sizeBytes: create.sizeBytes,
      checksumSha256: create.checksumSha256,
      purpose: create.purpose.toDto().text,
      isUpload: create.isUpload,
    );
    final result = await executorOf(executor).execute('''
INSERT INTO ${_T.tableName}
(${params.keys.join(', ')})
VALUES (${params.keys.map((key) => '@$key').join(', ')})
RETURNING $_selectColumns
''', parameters: params);

    return _Row.fromMap(result.first.toColumnMap()).toDomain();
  }

  @override
  Future<StorageObject?> delete(String id, {SqlExecutor? executor}) async {
    final result = await executorOf(executor).execute(
      '''
DELETE FROM ${_T.tableName}
WHERE ${_T.id} = @id
RETURNING $_selectColumns
''',
      parameters: {'id': id},
    );
    final row = result.firstOrNull;
    if (row == null) {
      return null;
    }

    return _Row.fromMap(row.toColumnMap()).toDomain();
  }

  // TODO: Handle empty patches consistently across all repository update methods.
  //  Proposal: `throw ArgumentError('At least one field must be present.')` in
  //  the generated code.
  @override
  Future<StorageObject?> update(
    String id,
    StorageObjectPatch patch, {
    SqlExecutor? executor,
  }) async {
    final Map<String, Object?> params = _T.update(
      storageKey: patch.storageKey,
      originalName: patch.originalName,
      mimeType: patch.mimeType,
      sizeBytes: patch.sizeBytes,
      checksumSha256: patch.checksumSha256,
      purpose: const .absent(),
      isUpload: const .absent(),
    );

    final result = await executorOf(executor).execute(
      '''
UPDATE ${_T.tableName}
SET ${params.keys.map((key) => '$key = @$key').join(', ')}
WHERE ${_T.id} = @id
RETURNING $_selectColumns
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

  String get _selectColumns => _T.columns
      .map((e) {
        if (e == _T.purpose) {
          return castColumnToText(_T.purpose);
        }
        return e;
      })
      .join(', ');
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
      purpose: StorageObjectPurposePgEnum.fromText(purpose).toDomain(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension on StorageObjectPurposePgEnum {
  StorageObjectPurpose toDomain() => switch (this) {
    .labImage => .labImage,
  };
}

extension on StorageObjectPurpose {
  StorageObjectPurposePgEnum toDto() => switch (this) {
    .labImage => .labImage,
  };
}
