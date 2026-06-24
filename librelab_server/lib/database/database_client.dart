import 'package:librelab_server/database/sql_executor/sql_executor.dart';
import 'package:librelab_server/database/sql_executor/sql_executor_postgres.dart';
import 'package:librelab_server/database/transaction_runner/transaction_runner.dart';
import 'package:librelab_server/database/transaction_runner/transaction_runner_postgres.dart';
import 'package:postgres/postgres.dart';

export 'package:postgres/postgres.dart' show PgException, ServerException;

abstract interface class SqlDatabaseAccess
    implements SqlExecutor, TransactionRunner {}

class DatabaseClient implements SqlDatabaseAccess {
  new pool({
    required String host,
    required int port,
    required String database,
    required String username,
    required String password,
    required SslMode sslMode,
    required int poolMaxConnectionCount,
  }) : this._(
         Pool<void>.withEndpoints(
           [
             Endpoint(
               host: host,
               port: port,
               database: database,
               username: username,
               password: password,
             ),
           ],
           settings: PoolSettings(
             sslMode: sslMode,
             maxConnectionCount: poolMaxConnectionCount,
           ),
         ),
       );

  DatabaseClient._(this._pool)
    : _executor = SqlExecutorPostgres(_pool),
      _transactionRunner = TransactionRunnerPostgres(_pool);

  final Pool<void> _pool;
  final SqlExecutor _executor;
  final TransactionRunner _transactionRunner;

  Future<void> testConnection() async {
    await execute('SELECT 1', ignoreRows: true);
  }

  @override
  Future<Result> execute(
    String statement, {
    Map<String, Object?>? parameters,
    bool ignoreRows = false,
    bool useSimpleQueryMode = false,
  }) => _executor.execute(
    statement,
    parameters: parameters,
    ignoreRows: ignoreRows,
    useSimpleQueryMode: useSimpleQueryMode,
  );

  @override
  Future<T> transaction<T>(
    Future<T> Function(TransactionSqlExecutor executor) fn, {
    TransactionSettings? settings,
  }) => _transactionRunner.transaction(fn, settings: settings);

  Future<void> close() => _pool.close();
}
