import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/sql_executor/sql_executor.dart';
import 'package:meta/meta.dart';

/// Provides the [executorOf] helper for repository implementations.
///
/// Repositories that do not need to resolve an optional [SqlExecutor]
/// do not need to extend this class.
abstract base class SqlRepository(
  @protected @nonVirtual final SqlDatabaseAccess db,
) {
  @protected
  @nonVirtual
  SqlExecutor executorOf(SqlExecutor? executor) {
    if (identical(executor, db)) {
      throw ArgumentError.value(
        executor,
        'executor',
        'must not pass the repository default executor',
      );
    }
    return executor ?? db;
  }
}
