// coverage:ignore-file
/// Generated code. Do not modify directly.
/// Instead, modify and then run: dart scripts/database_schema/generate.dart
library;

import 'package:meta/meta.dart';

/// Generated mapping for the `role_permissions` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class RolePermissionsTable {
  static const String tableName = 'role_permissions';

  static const String roleId = 'role_id';

  static const String permission = 'permission';

  static const List<String> columns = [roleId, permission];
}

/// Generated row mapping for the `role_permissions` table.
/// Represents a full-row result where all columns are expected to be present.
///
/// This model assumes SELECT queries include all columns defined in the table (i.e., `SELECT * FROM role_permissions`).
/// Partial SELECT projections are **not** supported and may result in runtime errors.
@immutable
final class RolePermissionsRow {
  const RolePermissionsRow({required this.roleId, required this.permission});

  factory RolePermissionsRow.fromMap(Map<String, Object?> map) =>
      RolePermissionsRow(
        roleId: (map[RolePermissionsTable.roleId]! as String),
        permission: (map[RolePermissionsTable.permission]! as String),
      );

  final String roleId;

  final String permission;
}

/// Generated mapping for the `roles` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class RolesTable {
  static const String tableName = 'roles';

  static const String id = 'id';

  static const String name = 'name';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const List<String> columns = [id, name, createdAt, updatedAt];
}

/// Generated row mapping for the `roles` table.
/// Represents a full-row result where all columns are expected to be present.
///
/// This model assumes SELECT queries include all columns defined in the table (i.e., `SELECT * FROM roles`).
/// Partial SELECT projections are **not** supported and may result in runtime errors.
@immutable
final class RolesRow {
  const RolesRow({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RolesRow.fromMap(Map<String, Object?> map) => RolesRow(
    id: (map[RolesTable.id]! as String),
    name: (map[RolesTable.name]! as String),
    createdAt: (map[RolesTable.createdAt]! as DateTime),
    updatedAt: (map[RolesTable.updatedAt]! as DateTime),
  );

  final String id;

  final String name;

  final DateTime createdAt;

  final DateTime updatedAt;
}

/// Generated mapping for the `schema_migrations` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class SchemaMigrationsTable {
  static const String tableName = 'schema_migrations';

  static const String version = 'version';

  static const String appliedAt = 'applied_at';

  static const List<String> columns = [version, appliedAt];
}

/// Generated row mapping for the `schema_migrations` table.
/// Represents a full-row result where all columns are expected to be present.
///
/// This model assumes SELECT queries include all columns defined in the table (i.e., `SELECT * FROM schema_migrations`).
/// Partial SELECT projections are **not** supported and may result in runtime errors.
@immutable
final class SchemaMigrationsRow {
  const SchemaMigrationsRow({required this.version, required this.appliedAt});

  factory SchemaMigrationsRow.fromMap(Map<String, Object?> map) =>
      SchemaMigrationsRow(
        version: (map[SchemaMigrationsTable.version]! as int),
        appliedAt: (map[SchemaMigrationsTable.appliedAt]! as DateTime),
      );

  final int version;

  final DateTime appliedAt;
}

/// Generated mapping for the `users` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class UsersTable {
  static const String tableName = 'users';

  static const String id = 'id';

  static const String email = 'email';

  static const String passwordHash = 'password_hash';

  static const String fullName = 'full_name';

  static const String isSuperuser = 'is_superuser';

  static const String roleId = 'role_id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const List<String> columns = [
    id,
    email,
    passwordHash,
    fullName,
    isSuperuser,
    roleId,
    createdAt,
    updatedAt,
  ];
}

/// Generated row mapping for the `users` table.
/// Represents a full-row result where all columns are expected to be present.
///
/// This model assumes SELECT queries include all columns defined in the table (i.e., `SELECT * FROM users`).
/// Partial SELECT projections are **not** supported and may result in runtime errors.
@immutable
final class UsersRow {
  const UsersRow({
    required this.id,
    required this.email,
    required this.passwordHash,
    required this.fullName,
    required this.isSuperuser,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UsersRow.fromMap(Map<String, Object?> map) => UsersRow(
    id: (map[UsersTable.id]! as String),
    email: (map[UsersTable.email]! as String),
    passwordHash: (map[UsersTable.passwordHash]! as String),
    fullName: (map[UsersTable.fullName]! as String),
    isSuperuser: (map[UsersTable.isSuperuser]! as bool),
    roleId: (map[UsersTable.roleId]! as String?),
    createdAt: (map[UsersTable.createdAt]! as DateTime),
    updatedAt: (map[UsersTable.updatedAt]! as DateTime),
  );

  final String id;

  final String email;

  final String passwordHash;

  final String fullName;

  final bool isSuperuser;

  final String? roleId;

  final DateTime createdAt;

  final DateTime updatedAt;
}
