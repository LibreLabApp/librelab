import 'package:librelab_shared/librelab_shared.dart';
import 'package:postgres/postgres.dart';

import 'generator.dart';

Future<void> main() async {
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
      optionalUpdateColumns: ['id', 'created_at', 'updated_at'],
    ),
  );
}
