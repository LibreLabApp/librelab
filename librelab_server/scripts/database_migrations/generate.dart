import 'generator.dart';

void main() {
  generate(
    const Config(
      input: 'migrations',
      // TODO: (REMOVE_SERVERPOD) update file path when moving all files under lib/src/ to lib/
      dartOutput: 'lib/src/database/database_migrations.g.dart',
      outputClassName: 'DatabaseMigrations',
      requiredTypesImport:
          'package:librelab_server/src/database/database_migration.dart',
    ),
  );
}
