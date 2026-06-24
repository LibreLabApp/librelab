import 'package:librelab_server/database/sql_executor/sql_executor.dart';
import 'package:postgres/postgres.dart' show TransactionSettings;

abstract interface class TransactionRunner {
  Future<T> transaction<T>(
    Future<T> Function(TransactionSqlExecutor executor) fn, {
    TransactionSettings? settings,
  });
}
