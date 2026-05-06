import 'package:postgres/postgres.dart';

const _defaultMaintenanceDb = 'postgres';

/// Creates a PostgreSQL database named [databaseName] if it does not exist.
/// No operation is performed if it already exists.
///
/// Returns whether the database was created.
Future<bool> createDbIfMissing({
  required String host,
  required int port,
  required String username,
  required String password,
  required String databaseName,
  required bool isUnixSocket,
  required bool requireSsl,
}) async {
  final conn = await Connection.open(
    Endpoint(
      host: host,
      port: port,
      database: _defaultMaintenanceDb,
      username: username,
      password: password,
      isUnixSocket: isUnixSocket,
    ),
    // Consistent with Serverpod:
    // https://github.com/serverpod/serverpod/blob/38a2da771460f8d50d7b0024b72c32f724f6cd70/packages/serverpod_database/lib/src/adapters/postgres/postgres_pool_manager.dart#L57
    settings: ConnectionSettings(sslMode: requireSsl ? .require : .disable),
  );

  try {
    final result = await conn.execute(
      Sql.named('SELECT 1 FROM pg_database WHERE datname = @name'),
      parameters: {'name': databaseName},
    );

    final exists = result.isNotEmpty;

    if (exists) {
      return false;
    }

    await conn.execute(Sql.named('CREATE DATABASE $databaseName'));

    return true;
  } finally {
    await conn.close();
  }
}
