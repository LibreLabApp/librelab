// coverage:ignore-file
/// Generated code. Do not modify directly.
/// Instead, modify and then run: dart scripts/database_schema/generate.dart
library;

import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

Map<String, Object?> _buildFieldMap<T>(
  List<(String key, Field<T> field)> entries,
) {
  final map = <String, Object?>{};

  void put(String key, Field<T> field) {
    if (field case Present(:final value)) {
      map[key] = value;
    }
  }

  for (final e in entries) {
    put(e.$1, e.$2);
  }

  return map;
}

/// Generated enum from PostgreSQL enum `permission`.
enum PermissionPgEnum {
  backupCreate('backup:create'),
  backupRestore('backup:restore');

  const PermissionPgEnum(this.text);

  final String text;

  static PermissionPgEnum fromText(String value) {
    return values.firstWhere(
      (e) => e.text == value,
      orElse: () => throw ArgumentError('Unknown enum value: $value'),
    );
  }
}

/// Generated mapping for the `role_permissions` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class RolePermissionsTable {
  static const String tableName = 'role_permissions';

  static const String roleId = 'role_id';

  static const String permission = 'permission';

  static const List<String> columns = [roleId, permission];

  static Map<String, Object> insert({
    required String roleId,
    required String permission,
  }) => {
    RolePermissionsTable.roleId: roleId,
    RolePermissionsTable.permission: permission,
  };

  static Map<String, Object?> update({
    required Field<String> roleId,
    required Field<String> permission,
  }) {
    return _buildFieldMap([
      (RolePermissionsTable.roleId, roleId),
      (RolePermissionsTable.permission, permission),
    ]);
  }
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
        roleId: (map[RolePermissionsTable.roleId] as String)!,
        permission: (map[RolePermissionsTable.permission] as String)!,
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

  static Map<String, Object> insert({
    String? id,
    required String name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => {
    RolesTable.id: ?id,
    RolesTable.name: name,
    RolesTable.createdAt: ?createdAt,
    RolesTable.updatedAt: ?updatedAt,
  };

  static Map<String, Object?> update({
    Field<String> id = const .absent(),
    required Field<String> name,
    Field<DateTime> createdAt = const .absent(),
    Field<DateTime> updatedAt = const .absent(),
  }) {
    return _buildFieldMap([
      (RolesTable.id, id),
      (RolesTable.name, name),
      (RolesTable.createdAt, createdAt),
      (RolesTable.updatedAt, updatedAt),
    ]);
  }
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
    id: (map[RolesTable.id] as String)!,
    name: (map[RolesTable.name] as String)!,
    createdAt: (map[RolesTable.createdAt] as DateTime)!,
    updatedAt: (map[RolesTable.updatedAt] as DateTime)!,
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

  static Map<String, Object> insert({
    required int version,
    DateTime? appliedAt,
  }) => {
    SchemaMigrationsTable.version: version,
    SchemaMigrationsTable.appliedAt: ?appliedAt,
  };

  static Map<String, Object?> update({
    required Field<int> version,
    required Field<DateTime> appliedAt,
  }) {
    return _buildFieldMap([
      (SchemaMigrationsTable.version, version),
      (SchemaMigrationsTable.appliedAt, appliedAt),
    ]);
  }
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
        version: (map[SchemaMigrationsTable.version] as int)!,
        appliedAt: (map[SchemaMigrationsTable.appliedAt] as DateTime)!,
      );

  final int version;

  final DateTime appliedAt;
}

/// Generated mapping for the `user_refresh_tokens` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class UserRefreshTokensTable {
  static const String tableName = 'user_refresh_tokens';

  static const String id = 'id';

  static const String userId = 'user_id';

  static const String tokenHash = 'token_hash';

  static const String deviceId = 'device_id';

  static const String ipAddress = 'ip_address';

  static const String userAgent = 'user_agent';

  static const String expiresAt = 'expires_at';

  static const String createdAt = 'created_at';

  static const List<String> columns = [
    id,
    userId,
    tokenHash,
    deviceId,
    ipAddress,
    userAgent,
    expiresAt,
    createdAt,
  ];

  static Map<String, Object> insert({
    int? id,
    required String userId,
    required String tokenHash,
    required String? deviceId,
    required String? ipAddress,
    required String? userAgent,
    required DateTime expiresAt,
    DateTime? createdAt,
  }) => {
    UserRefreshTokensTable.id: ?id,
    UserRefreshTokensTable.userId: userId,
    UserRefreshTokensTable.tokenHash: tokenHash,
    UserRefreshTokensTable.deviceId: ?deviceId,
    UserRefreshTokensTable.ipAddress: ?ipAddress,
    UserRefreshTokensTable.userAgent: ?userAgent,
    UserRefreshTokensTable.expiresAt: expiresAt,
    UserRefreshTokensTable.createdAt: ?createdAt,
  };

  static Map<String, Object?> update({
    Field<int> id = const .absent(),
    required Field<String> userId,
    required Field<String> tokenHash,
    required Field<String?> deviceId,
    required Field<String?> ipAddress,
    required Field<String?> userAgent,
    required Field<DateTime> expiresAt,
    Field<DateTime> createdAt = const .absent(),
  }) {
    return _buildFieldMap([
      (UserRefreshTokensTable.id, id),
      (UserRefreshTokensTable.userId, userId),
      (UserRefreshTokensTable.tokenHash, tokenHash),
      (UserRefreshTokensTable.deviceId, deviceId),
      (UserRefreshTokensTable.ipAddress, ipAddress),
      (UserRefreshTokensTable.userAgent, userAgent),
      (UserRefreshTokensTable.expiresAt, expiresAt),
      (UserRefreshTokensTable.createdAt, createdAt),
    ]);
  }
}

/// Generated row mapping for the `user_refresh_tokens` table.
/// Represents a full-row result where all columns are expected to be present.
///
/// This model assumes SELECT queries include all columns defined in the table (i.e., `SELECT * FROM user_refresh_tokens`).
/// Partial SELECT projections are **not** supported and may result in runtime errors.
@immutable
final class UserRefreshTokensRow {
  const UserRefreshTokensRow({
    required this.id,
    required this.userId,
    required this.tokenHash,
    required this.deviceId,
    required this.ipAddress,
    required this.userAgent,
    required this.expiresAt,
    required this.createdAt,
  });

  factory UserRefreshTokensRow.fromMap(Map<String, Object?> map) =>
      UserRefreshTokensRow(
        id: (map[UserRefreshTokensTable.id] as int)!,
        userId: (map[UserRefreshTokensTable.userId] as String)!,
        tokenHash: (map[UserRefreshTokensTable.tokenHash] as String)!,
        deviceId: (map[UserRefreshTokensTable.deviceId] as String?),
        ipAddress: (map[UserRefreshTokensTable.ipAddress] as String?),
        userAgent: (map[UserRefreshTokensTable.userAgent] as String?),
        expiresAt: (map[UserRefreshTokensTable.expiresAt] as DateTime)!,
        createdAt: (map[UserRefreshTokensTable.createdAt] as DateTime)!,
      );

  final int id;

  final String userId;

  final String tokenHash;

  final String? deviceId;

  final String? ipAddress;

  final String? userAgent;

  final DateTime expiresAt;

  final DateTime createdAt;
}

/// Generated mapping for the `users` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class UsersTable {
  static const String tableName = 'users';

  static const String id = 'id';

  static const String email = 'email';

  static const String passwordHash = 'password_hash';

  static const String tokenVersion = 'token_version';

  static const String fullName = 'full_name';

  static const String phoneNumber = 'phone_number';

  static const String isSuperuser = 'is_superuser';

  static const String roleId = 'role_id';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const List<String> columns = [
    id,
    email,
    passwordHash,
    tokenVersion,
    fullName,
    phoneNumber,
    isSuperuser,
    roleId,
    createdAt,
    updatedAt,
  ];

  static Map<String, Object> insert({
    String? id,
    required String email,
    required String passwordHash,
    int? tokenVersion,
    required String fullName,
    required String? phoneNumber,
    bool? isSuperuser,
    required String? roleId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => {
    UsersTable.id: ?id,
    UsersTable.email: email,
    UsersTable.passwordHash: passwordHash,
    UsersTable.tokenVersion: ?tokenVersion,
    UsersTable.fullName: fullName,
    UsersTable.phoneNumber: ?phoneNumber,
    UsersTable.isSuperuser: ?isSuperuser,
    UsersTable.roleId: ?roleId,
    UsersTable.createdAt: ?createdAt,
    UsersTable.updatedAt: ?updatedAt,
  };

  static Map<String, Object?> update({
    Field<String> id = const .absent(),
    required Field<String> email,
    required Field<String> passwordHash,
    required Field<int> tokenVersion,
    required Field<String> fullName,
    required Field<String?> phoneNumber,
    required Field<bool> isSuperuser,
    required Field<String?> roleId,
    Field<DateTime> createdAt = const .absent(),
    Field<DateTime> updatedAt = const .absent(),
  }) {
    return _buildFieldMap([
      (UsersTable.id, id),
      (UsersTable.email, email),
      (UsersTable.passwordHash, passwordHash),
      (UsersTable.tokenVersion, tokenVersion),
      (UsersTable.fullName, fullName),
      (UsersTable.phoneNumber, phoneNumber),
      (UsersTable.isSuperuser, isSuperuser),
      (UsersTable.roleId, roleId),
      (UsersTable.createdAt, createdAt),
      (UsersTable.updatedAt, updatedAt),
    ]);
  }
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
    required this.tokenVersion,
    required this.fullName,
    required this.phoneNumber,
    required this.isSuperuser,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UsersRow.fromMap(Map<String, Object?> map) => UsersRow(
    id: (map[UsersTable.id] as String)!,
    email: (map[UsersTable.email] as String)!,
    passwordHash: (map[UsersTable.passwordHash] as String)!,
    tokenVersion: (map[UsersTable.tokenVersion] as int)!,
    fullName: (map[UsersTable.fullName] as String)!,
    phoneNumber: (map[UsersTable.phoneNumber] as String?),
    isSuperuser: (map[UsersTable.isSuperuser] as bool)!,
    roleId: (map[UsersTable.roleId] as String?),
    createdAt: (map[UsersTable.createdAt] as DateTime)!,
    updatedAt: (map[UsersTable.updatedAt] as DateTime)!,
  );

  final String id;

  final String email;

  final String passwordHash;

  final int tokenVersion;

  final String fullName;

  final String? phoneNumber;

  final bool isSuperuser;

  final String? roleId;

  final DateTime createdAt;

  final DateTime updatedAt;
}
