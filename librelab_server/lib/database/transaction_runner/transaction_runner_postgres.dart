import 'package:librelab_server/database/sql_executor/sql_executor.dart';
import 'package:librelab_server/database/sql_executor/sql_executor_postgres.dart';
import 'package:librelab_server/database/transaction_runner/transaction_runner.dart';
import 'package:postgres/postgres.dart';

class TransactionRunnerPostgres(final SessionExecutor _sessionExecutor)
    implements TransactionRunner {
  @override
  Future<T> transaction<T>(
    Future<T> Function(TransactionSqlExecutor executor) fn, {
    TransactionSettings? settings,
  }) => _sessionExecutor.runTx(
    (s) => fn(TransactionSqlExecutorPostgres(s)),
    settings: settings,
  );
}
