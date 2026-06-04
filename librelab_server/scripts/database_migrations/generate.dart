import 'generator.dart';

void main() {
  generate(
    const Config(
      input: 'migrations',
      dartOutput: 'lib/database/database_migrations.g.dart',
      outputClassName: 'DatabaseMigrations',
      requiredTypesImport:
          'package:librelab_server/database/database_migration.dart',
    ),
  );
}
