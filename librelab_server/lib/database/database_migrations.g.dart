// coverage:ignore-file
/// Generated code. Do not modify directly.
/// Instead, modify and then run: dart scripts/database_migrations/generate.dart
library;

import 'package:librelab_server/database/database_migration.dart';

/// Generated code. Do not **modify** directly.
///
/// Database migration scripts.
/// This approach avoids reading system files at runtime,
/// which is error-prone, can be deleted by the user, and is harder to bundle.
abstract final class DatabaseMigrations {
  static final List<DatabaseMigration> list = const [
    DatabaseMigration(
      version: 1,
      sql:
          'CREATE EXTENSION IF NOT EXISTS pgcrypto;\n\nCREATE TABLE\n    users (\n        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n        email TEXT NOT NULL UNIQUE,\n        password_hash TEXT NOT NULL\n    );\n',
    ),
  ];
}
