import 'package:librelab_server/database/sql_executor/sql_executor.dart';
import 'package:postgres/postgres.dart';

class SqlExecutorPostgres(final Session _session) implements SqlExecutor {
  @override
  Future<Result> execute(
    String statement, {
    Map<String, Object?>? parameters,
    bool ignoreRows = false,
    bool useSimpleQueryMode = false,
  }) => _session._execute(
    statement,
    parameters: parameters,
    ignoreRows: ignoreRows,
    useSimpleQueryMode: useSimpleQueryMode,
  );
}

class TransactionSqlExecutorPostgres(final TxSession _session)
    implements TransactionSqlExecutor {
  @override
  Future<Result> execute(
    String statement, {
    Map<String, Object?>? parameters,
    bool ignoreRows = false,
    bool useSimpleQueryMode = false,
  }) => _session._execute(
    statement,
    parameters: parameters,
    ignoreRows: ignoreRows,
    useSimpleQueryMode: useSimpleQueryMode,
  );

  @override
  Future<void> rollback() => _session.rollback();
}

extension on Session {
  Future<Result> _execute(
    String statement, {
    Map<String, Object?>? parameters,
    bool ignoreRows = false,
    bool useSimpleQueryMode = false,
  }) {
    return execute(
      parameters != null ? Sql.named(statement) : Sql(statement),
      parameters: parameters,
      ignoreRows: ignoreRows,
      queryMode: useSimpleQueryMode ? .simple : null,
    );
  }
}
