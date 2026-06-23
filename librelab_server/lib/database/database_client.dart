import 'package:postgres/postgres.dart';

export 'package:postgres/postgres.dart'
    show PgException, Result, ServerException, Sql, SslMode;

class DatabaseClient {
  DatabaseClient._(this._connection);

  new fromConnection(Connection connection) : _connection = connection;

  final Connection _connection;

  static Future<DatabaseClient> connect({
    required String host,
    required int port,
    required String database,
    required String username,
    required String password,
    required SslMode sslMode,
  }) async {
    final connection = await Connection.open(
      Endpoint(
        host: host,
        port: port,
        database: database,
        username: username,
        password: password,
      ),
      settings: ConnectionSettings(sslMode: sslMode),
    );

    return DatabaseClient._(connection);
  }

  Future<Result> execute(Sql sql, {Map<String, Object?>? parameters}) async {
    final result = await _connection.execute(sql, parameters: parameters);
    return result;
  }

  Future<T> transaction<T>(
    Future<T> Function(TxSession session) fn, {
    TransactionSettings? settings,
  }) async {
    return _connection.runTx(fn, settings: settings);
  }

  Future<void> close() => _connection.close();
}
