import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_migration_runner.dart';
import 'package:librelab_server/database/database_migrations.g.dart';
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
      requiredTypesImport: 'package:optional_field/optional_field.dart',
      optionalInsertColumns: ['id', 'created_at', 'updated_at'],
      optionalUpdateColumns: ['id', 'created_at'],
      updateColumnDefaults: {'updated_at': 'now()'},
      applyMigrations: (databaseConnection) async {
        await DatabaseMigrationRunner(
          client: DatabaseClient.fromConnection(databaseConnection),
          migrations: DatabaseMigrations.list,
          latestVersion: DatabaseMigrations.latest,
          logger: Logger('DatabaseMigrationRunner'),
        ).run();
      },
    ),
  );
}
