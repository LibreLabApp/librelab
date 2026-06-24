import 'package:postgres/postgres.dart' show Result;

/// Abstraction for executing SQL statements.
abstract interface class SqlExecutor {
  /// Executes the [statement] with the given [parameters] (named parameters).
  ///
  /// When [ignoreRows] is set to `true`, the implementation may internally
  /// optimize the execution to ignore rows returned by the query.
  Future<Result> execute(
    String statement, {
    Map<String, Object?>? parameters,
    bool ignoreRows = false,
    bool useSimpleQueryMode = false,
  });
}

abstract interface class TransactionSqlExecutor implements SqlExecutor {
  Future<void> rollback();
}
