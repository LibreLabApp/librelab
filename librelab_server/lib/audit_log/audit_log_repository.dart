import 'package:librelab_server/audit_log/audit_log.dart';
import 'package:librelab_server/database/sql_executor/sql_executor.dart';

abstract interface class AuditLogRepository {
  Future<AuditLog> create(AuditLogCreate create, {SqlExecutor? executor});
}
