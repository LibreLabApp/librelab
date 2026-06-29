import 'package:librelab_server/audit_log/audit_log.dart';
import 'package:librelab_server/audit_log/audit_log_repository.dart';
import 'package:librelab_server/database/database_schema.g.dart';
import 'package:librelab_server/database/sql_executor/sql_executor.dart';
import 'package:librelab_server/database/sql_executor/sql_repository.dart';
import 'package:librelab_server/database/utils/postgresql_utils.dart';

typedef _T = AuditLogsTable;
typedef _Row = AuditLogsRow;

final class AuditLogRepositoryPostgres(super.db)
    extends SqlRepository
    implements AuditLogRepository {
  @override
  Future<AuditLog> create(
    AuditLogCreate create, {
    SqlExecutor? executor,
  }) async {
    final Map<String, Object> params = _T.insert(
      userId: create.userId,
      action: create.action._toDto().text,
      entityType: create.entityType._toDto().text,
      entityId: create.entityId,
      oldValue: create.oldValue,
      newValue: create.newValue,
      ipAddress: create.requestMetadata.ipAddress,
      userAgent: create.requestMetadata.userAgent,
    );
    final result = await executorOf(executor).execute('''
INSERT INTO ${_T.tableName}
(${params.keys.join(', ')})
VALUES (${params.keys.map((key) => '@$key').join(', ')})
RETURNING $_selectColumns
''', parameters: params);

    final row = _Row.fromMap(result.first.toColumnMap());
    return row._toDomain();
  }

  String get _selectColumns => _T.columns
      .map((e) {
        if (e == _T.entityType) {
          return castColumnToText(_T.entityType);
        }
        if (e == _T.action) {
          return castColumnToText(_T.action);
        }
        if (e == _T.ipAddress) {
          return castColumnToText(_T.ipAddress);
        }
        return e;
      })
      .join(', ');
}

extension on AuditAction {
  AuditActionPgEnum _toDto() => switch (this) {
    .create => .create,
    .update => .update,
    .delete => .delete,
  };
}

extension on AuditEntityType {
  AuditEntityTypePgEnum _toDto() => switch (this) {
    .labSettings => .labSettings,
  };
}

extension on _Row {
  AuditLog _toDomain() => .new(
    id: id,
    userId: userId,
    action: switch (AuditActionPgEnum.fromText(action)) {
      .create => .create,
      .update => .update,
      .delete => .delete,
    },
    entityType: switch (AuditEntityTypePgEnum.fromText(entityType)) {
      .labSettings => .labSettings,
    },
    entityId: entityId,
    oldValue: oldValue,
    newValue: newValue,
    requestMetadata: RequestMetadata(
      ipAddress: ipAddress,
      userAgent: userAgent,
    ),
    createdAt: createdAt,
  );
}
