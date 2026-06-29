import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_migration_runner.dart';
import 'package:librelab_server/database/database_migrations.g.dart';
import 'package:librelab_server/database/sql_executor/sql_executor.dart';
import 'package:librelab_server/database/sql_executor/sql_executor_postgres.dart';
import 'package:librelab_server/database/transaction_runner/transaction_runner.dart';
import 'package:librelab_server/database/transaction_runner/transaction_runner_postgres.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';
import 'package:postgres/postgres.dart';

import 'generator.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print(record.message);
  });

  await generate(
    Config(
      input: Endpoint(
        host: 'localhost',
        database: ProjectConstants.defaultDbName,
        username: ProjectConstants.defaultUsername,
        password: 'oHhK1voPC92Yrg5ZAEfQhd1q2yEyzdtW',
        port: 8090,
      ),
      dartOutput: 'lib/database/database_schema.g.dart',
      requiredTypeImports: const [
        ('package:json_utils/json_utils.dart', ['JsonMap']),
        ('package:meta/meta.dart', ['immutable']),
        ('package:optional_field/optional_field.dart', ['Field', 'Present']),
      ],
      optionalInsertColumns: const ['id', 'created_at', 'updated_at'],
      optionalUpdateColumns: const ['id', 'created_at'],
      updateColumnDefaults: const {'updated_at': 'now()'},
      applyMigrations: (databaseConnection) async {
        await DatabaseMigrationRunner(
          db: _DatabaseAccessConnection._(databaseConnection),
          migrations: DatabaseMigrations.list,
          latestVersion: DatabaseMigrations.latest,
          logger: Logger('DatabaseMigrationRunner'),
        ).run();
      },
    ),
  );
}

class _DatabaseAccessConnection implements SqlDatabaseAccess {
  _DatabaseAccessConnection._(Connection connection)
    : _executor = SqlExecutorPostgres(connection),
      _runner = TransactionRunnerPostgres(connection);

  final SqlExecutor _executor;
  final TransactionRunner _runner;

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
  }) => _runner.transaction(fn, settings: settings);
}
