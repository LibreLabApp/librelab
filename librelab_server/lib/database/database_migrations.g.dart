// coverage:ignore-file
// ignore_for_file: avoid_escaping_inner_quotes, unnecessary_string_escapes
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
  static const List<DatabaseMigration> list = [
    DatabaseMigration(
      version: 1,
      sql:
          'CREATE TYPE permission AS ENUM (\n  \'backup:create\',\n  \'backup:restore\',\n  \'lab_settings:update\'\n);\n\nCREATE TABLE roles (\n  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,\n  name TEXT NOT NULL UNIQUE,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()\n);\n\nCREATE TABLE role_permissions (\n  role_id BIGINT NOT NULL REFERENCES roles(id) ON DELETE CASCADE,\n  permission permission NOT NULL,\n  PRIMARY KEY (role_id, permission)\n);\n\nCREATE TABLE users (\n  id UUID PRIMARY KEY DEFAULT uuidv7(),\n  email TEXT NOT NULL UNIQUE,\n  password_hash TEXT NOT NULL,\n  token_version INTEGER NOT NULL DEFAULT 0,\n  full_name TEXT NOT NULL,\n  phone_number TEXT,\n  is_superuser BOOLEAN NOT NULL DEFAULT FALSE,\n  role_id BIGINT REFERENCES roles(id),\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),\n\n  CONSTRAINT users_email_length_check\n    CHECK (length(email) BETWEEN 3 AND 254),\n\n  CONSTRAINT users_email_format_check\n    CHECK (email ~* \'^[A-Z0-9.!#\$%&\'\'*+/=?^_`{|}~-]+@[A-Z0-9-]+(\.[A-Z0-9-]+)*\.[A-Z]{2,}\$\'),\n\n  CONSTRAINT users_password_hash_length_check\n    CHECK (length(password_hash) <= 1024),\n\n  CONSTRAINT users_token_version_check\n    CHECK (token_version >= 0),\n\n  CONSTRAINT users_full_name_length_check\n    CHECK (length(full_name) BETWEEN 1 AND 100),\n\n  CONSTRAINT users_phone_number_length_check\n    CHECK (phone_number IS NULL OR length(phone_number) <= 20),\n\n  CONSTRAINT users_superuser_role_check\n    CHECK (\n      (is_superuser AND role_id IS NULL)\n      OR\n      (NOT is_superuser AND role_id IS NOT NULL)\n    )\n);\n\nCREATE TABLE user_refresh_tokens (\n  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,\n  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,\n  token_hash TEXT NOT NULL UNIQUE,\n  device_id TEXT,\n  ip_address INET,\n  user_agent TEXT,\n  expires_at TIMESTAMPTZ NOT NULL,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now()\n);\n\nCREATE INDEX user_refresh_tokens_expires_at_idx ON user_refresh_tokens(expires_at);\nCREATE INDEX user_refresh_tokens_user_id_idx ON user_refresh_tokens(user_id);\n\nCREATE TYPE login_result AS ENUM (\n  \'success\',\n  \'invalid_credentials\',\n  \'validation_error\',\n  \'user_not_found\',\n  \'locked\',\n  \'login_disabled\',\n  \'rate_limited\'\n);\n\nCREATE TABLE login_attempts (\n  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,\n  user_id UUID,\n  email TEXT NOT NULL,\n  result login_result NOT NULL,\n  ip_address INET,\n  user_agent TEXT,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now()\n);\n\nCREATE TABLE lab_settings (\n  -- Singleton\n  id INTEGER PRIMARY KEY DEFAULT 1,\n  lab_name TEXT,\n  login_disabled BOOLEAN NOT NULL DEFAULT FALSE,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),\n\n  CONSTRAINT lab_settings_singleton_check\n    CHECK (id = 1)\n);\n\nCREATE TYPE audit_action AS ENUM (\n  \'create\',\n  \'update\',\n  \'delete\'\n);\n\nCREATE TYPE audit_entity_type AS ENUM (\n  \'lab_settings\'\n);\n\nCREATE TABLE audit_logs (\n  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,\n  user_id UUID NOT NULL,\n  action audit_action NOT NULL,\n  entity_type audit_entity_type NOT NULL,\n  entity_id TEXT NOT NULL,\n  old_value JSONB NOT NULL,\n  new_value JSONB NOT NULL,\n  ip_address INET,\n  user_agent TEXT,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now()\n);\n\nCREATE TABLE files (\n  id UUID PRIMARY KEY DEFAULT uuidv7(),\n  storage_key TEXT NOT NULL UNIQUE,\n  original_name TEXT NOT NULL,\n  mime_type TEXT,\n  size_bytes BIGINT NOT NULL,\n  checksum_sha256 TEXT NOT NULL,\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now()\n);\n',
    ),
  ];

  static const int latest = 1;
}
