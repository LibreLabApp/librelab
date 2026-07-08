import 'dart:io';

import 'package:librelab_server/config/app_config/database_config.dart';
import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';

Future<DatabaseClient> connectDatabase({
  required DatabaseConfig databaseConfig,
  required String password,
  required Shutdown shutdown,
}) async {
  try {
    final client = DatabaseClient.pool(
      host: databaseConfig.host,
      port: databaseConfig.port,
      database: databaseConfig.name,
      username: databaseConfig.user,
      password: password,
      sslMode: switch (databaseConfig.sslMode) {
        .disable => .disable,
        .require => .require,
        .verifyFull => .verifyFull,
      },
      poolMaxConnectionCount: databaseConfig.pool.maxConnectionCount,
    );

    // Fails fast if the database is unreachable or misconfigured.
    await client.testConnection();

    return client;
  } on Exception catch (e) {
    final String message;
    if (e is SocketException) {
      message =
          '(network error).\n'
          'Cause: Unable to reach host or port (${databaseConfig.host}:${databaseConfig.port}).\n'
          'Details: $e';
    } else if (e is PgException) {
      final cause = () {
        if (e is ServerException) {
          if (e.code == '28P01') {
            return 'authentication failure (invalid username or password)';
          }
          if (e.code == '3D000') {
            return 'database does not exist';
          }
        }
        return 'server rejected connection';
      }();

      message =
          '(PostgreSQL error).\n'
          'Cause: $cause.\n'
          'Details: $e';
    } else {
      message =
          '(unexpected error).\n'
          'Cause: Unclassified failure during initialization.\n'
          'Details: $e';
    }
    stderr.writeln('\nDatabase connection failed $message');
    await shutdown(isSuccess: false);
  }
}
