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
          'CREATE TYPE permission AS ENUM (\n  \'backup:create\',\n  \'backup:restore\'\n);\n\nCREATE TABLE roles (\n  id UUID PRIMARY KEY DEFAULT uuidv7(),\n  name TEXT NOT NULL UNIQUE,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()\n);\n\nCREATE TABLE role_permissions (\n  role_id UUID NOT NULL REFERENCES roles(id) ON DELETE CASCADE,\n  permission permission NOT NULL,\n  PRIMARY KEY (role_id, permission)\n);\n\nCREATE TABLE users (\n  id UUID PRIMARY KEY DEFAULT uuidv7(),\n  email TEXT NOT NULL UNIQUE,\n  password_hash TEXT NOT NULL,\n  full_name TEXT NOT NULL,\n  is_superuser BOOLEAN NOT NULL DEFAULT FALSE,\n  role_id UUID REFERENCES roles(id),\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),\n  CONSTRAINT users_superuser_role_check\n    CHECK (\n      (is_superuser AND role_id IS NULL)\n      OR\n      (NOT is_superuser AND role_id IS NOT NULL)\n    )\n);\n',
    ),
  ];
}
