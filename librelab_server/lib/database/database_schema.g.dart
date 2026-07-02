// coverage:ignore-file
// ignore_for_file: unnecessary_parenthesis
/// Generated code. Do not modify directly.
/// Instead, modify and then run: dart scripts/database_schema/generate.dart
library;

import 'package:json_safe/json_safe.dart' show JsonMap;
import 'package:meta/meta.dart' show immutable;
import 'package:optional_field/optional_field.dart' show Field, Present;

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

/// Generated enum from PostgreSQL enum `audit_action`.
enum AuditActionPgEnum {
  create('create'),
  update('update'),
  delete('delete');

  const AuditActionPgEnum(this.text);

  final String text;

  static AuditActionPgEnum fromText(String value) {
    return values.firstWhere(
      (e) => e.text == value,
      orElse: () => throw ArgumentError('Unknown enum value: $value'),
    );
  }
}

/// Generated enum from PostgreSQL enum `audit_entity_type`.
enum AuditEntityTypePgEnum {
  labSettings('lab_settings');

  const AuditEntityTypePgEnum(this.text);

  final String text;

  static AuditEntityTypePgEnum fromText(String value) {
    return values.firstWhere(
      (e) => e.text == value,
      orElse: () => throw ArgumentError('Unknown enum value: $value'),
    );
  }
}

/// Generated enum from PostgreSQL enum `login_result`.
enum LoginResultPgEnum {
  success('success'),
  invalidCredentials('invalid_credentials'),
  validationError('validation_error'),
  userNotFound('user_not_found'),
  locked('locked'),
  loginDisabled('login_disabled'),
  rateLimited('rate_limited');

  const LoginResultPgEnum(this.text);

  final String text;

  static LoginResultPgEnum fromText(String value) {
    return values.firstWhere(
      (e) => e.text == value,
      orElse: () => throw ArgumentError('Unknown enum value: $value'),
    );
  }
}

/// Generated enum from PostgreSQL enum `permission`.
enum PermissionPgEnum {
  backupCreate('backup:create'),
  backupRestore('backup:restore'),
  labSettingsUpdate('lab_settings:update');

  const PermissionPgEnum(this.text);

  final String text;

  static PermissionPgEnum fromText(String value) {
    return values.firstWhere(
      (e) => e.text == value,
      orElse: () => throw ArgumentError('Unknown enum value: $value'),
    );
  }
}

/// Generated mapping for the `audit_logs` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class AuditLogsTable {
  static const String tableName = 'audit_logs';

  static const String id = 'id';

  static const String userId = 'user_id';

  static const String action = 'action';

  static const String entityType = 'entity_type';

  static const String entityId = 'entity_id';

  static const String oldValue = 'old_value';

  static const String newValue = 'new_value';

  static const String ipAddress = 'ip_address';

  static const String userAgent = 'user_agent';

  static const String createdAt = 'created_at';

  static const List<String> columns = [
    id,
    userId,
    action,
    entityType,
    entityId,
    oldValue,
    newValue,
    ipAddress,
    userAgent,
    createdAt,
  ];

  static Map<String, Object> insert({
    int? id,
    required String userId,
    required String action,
    required String entityType,
    required String entityId,
    required JsonMap oldValue,
    required JsonMap newValue,
    required String? ipAddress,
    required String? userAgent,
    DateTime? createdAt,
  }) => {
    AuditLogsTable.id: ?id,
    AuditLogsTable.userId: userId,
    AuditLogsTable.action: action,
    AuditLogsTable.entityType: entityType,
    AuditLogsTable.entityId: entityId,
    AuditLogsTable.oldValue: oldValue,
    AuditLogsTable.newValue: newValue,
    AuditLogsTable.ipAddress: ?ipAddress,
    AuditLogsTable.userAgent: ?userAgent,
    AuditLogsTable.createdAt: ?createdAt,
  };

  static Map<String, Object?> update({
    Field<int> id = const .absent(),
    required Field<String> userId,
    required Field<String> action,
    required Field<String> entityType,
    required Field<String> entityId,
    required Field<JsonMap> oldValue,
    required Field<JsonMap> newValue,
    required Field<String?> ipAddress,
    required Field<String?> userAgent,
    Field<DateTime> createdAt = const .absent(),
  }) {
    return _buildFieldMap([
      (AuditLogsTable.id, id),
      (AuditLogsTable.userId, userId),
      (AuditLogsTable.action, action),
      (AuditLogsTable.entityType, entityType),
      (AuditLogsTable.entityId, entityId),
      (AuditLogsTable.oldValue, oldValue),
      (AuditLogsTable.newValue, newValue),
      (AuditLogsTable.ipAddress, ipAddress),
      (AuditLogsTable.userAgent, userAgent),
      (AuditLogsTable.createdAt, createdAt),
    ]);
  }
}

/// Generated row mapping for the `audit_logs` table.
/// Represents a full-row result where all columns are expected to be present.
///
/// This model assumes SELECT queries include all columns defined in the table (i.e., `SELECT * FROM audit_logs`).
/// Partial SELECT projections are **not** supported and may result in runtime errors.
@immutable
final class AuditLogsRow {
  const AuditLogsRow({
    required this.id,
    required this.userId,
    required this.action,
    required this.entityType,
    required this.entityId,
    required this.oldValue,
    required this.newValue,
    required this.ipAddress,
    required this.userAgent,
    required this.createdAt,
  });

  factory AuditLogsRow.fromMap(Map<String, Object?> map) => AuditLogsRow(
    id: (map[AuditLogsTable.id]! as int),
    userId: (map[AuditLogsTable.userId]! as String),
    action: (map[AuditLogsTable.action]! as String),
    entityType: (map[AuditLogsTable.entityType]! as String),
    entityId: (map[AuditLogsTable.entityId]! as String),
    oldValue: (map[AuditLogsTable.oldValue]! as JsonMap),
    newValue: (map[AuditLogsTable.newValue]! as JsonMap),
    ipAddress: (map[AuditLogsTable.ipAddress] as String?),
    userAgent: (map[AuditLogsTable.userAgent] as String?),
    createdAt: (map[AuditLogsTable.createdAt]! as DateTime),
  );

  final int id;

  final String userId;

  /// Requires casting to TEXT when selecting this column (i..e, SELECT action::text)
  final String action;

  /// Requires casting to TEXT when selecting this column (i..e, SELECT entity_type::text)
  final String entityType;

  final String entityId;

  final JsonMap oldValue;

  final JsonMap newValue;

  /// Requires casting to TEXT when selecting this column (i..e, SELECT ip_address::text)
  final String? ipAddress;

  final String? userAgent;

  final DateTime createdAt;
}

/// Generated mapping for the `lab_settings` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class LabSettingsTable {
  static const String tableName = 'lab_settings';

  static const String id = 'id';

  static const String labName = 'lab_name';

  static const String loginDisabled = 'login_disabled';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';

  static const List<String> columns = [
    id,
    labName,
    loginDisabled,
    createdAt,
    updatedAt,
  ];

  static Map<String, Object> insert({
    int? id,
    required String? labName,
    bool? loginDisabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => {
    LabSettingsTable.id: ?id,
    LabSettingsTable.labName: ?labName,
    LabSettingsTable.loginDisabled: ?loginDisabled,
    LabSettingsTable.createdAt: ?createdAt,
    LabSettingsTable.updatedAt: ?updatedAt,
  };

  static Map<String, Object?> update({
    Field<int> id = const .absent(),
    required Field<String?> labName,
    required Field<bool> loginDisabled,
    Field<DateTime> createdAt = const .absent(),
  }) {
    return _buildFieldMap([
      (LabSettingsTable.id, id),
      (LabSettingsTable.labName, labName),
      (LabSettingsTable.loginDisabled, loginDisabled),
      (LabSettingsTable.createdAt, createdAt),
      (LabSettingsTable.updatedAt, const .value('now()')),
    ]);
  }
}

/// Generated row mapping for the `lab_settings` table.
/// Represents a full-row result where all columns are expected to be present.
///
/// This model assumes SELECT queries include all columns defined in the table (i.e., `SELECT * FROM lab_settings`).
/// Partial SELECT projections are **not** supported and may result in runtime errors.
@immutable
final class LabSettingsRow {
  const LabSettingsRow({
    required this.id,
    required this.labName,
    required this.loginDisabled,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LabSettingsRow.fromMap(Map<String, Object?> map) => LabSettingsRow(
    id: (map[LabSettingsTable.id]! as int),
    labName: (map[LabSettingsTable.labName] as String?),
    loginDisabled: (map[LabSettingsTable.loginDisabled]! as bool),
    createdAt: (map[LabSettingsTable.createdAt]! as DateTime),
    updatedAt: (map[LabSettingsTable.updatedAt]! as DateTime),
  );

  final int id;

  final String? labName;

  final bool loginDisabled;

  final DateTime createdAt;

  final DateTime updatedAt;
}

/// Generated mapping for the `login_attempts` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class LoginAttemptsTable {
  static const String tableName = 'login_attempts';

  static const String id = 'id';

  static const String userId = 'user_id';

  static const String email = 'email';

  static const String result = 'result';

  static const String ipAddress = 'ip_address';

  static const String userAgent = 'user_agent';

  static const String createdAt = 'created_at';

  static const List<String> columns = [
    id,
    userId,
    email,
    result,
    ipAddress,
    userAgent,
    createdAt,
  ];

  static Map<String, Object> insert({
    int? id,
    required String? userId,
    required String email,
    required String result,
    required String? ipAddress,
    required String? userAgent,
    DateTime? createdAt,
  }) => {
    LoginAttemptsTable.id: ?id,
    LoginAttemptsTable.userId: ?userId,
    LoginAttemptsTable.email: email,
    LoginAttemptsTable.result: result,
    LoginAttemptsTable.ipAddress: ?ipAddress,
    LoginAttemptsTable.userAgent: ?userAgent,
    LoginAttemptsTable.createdAt: ?createdAt,
  };

  static Map<String, Object?> update({
    Field<int> id = const .absent(),
    required Field<String?> userId,
    required Field<String> email,
    required Field<String> result,
    required Field<String?> ipAddress,
    required Field<String?> userAgent,
    Field<DateTime> createdAt = const .absent(),
  }) {
    return _buildFieldMap([
      (LoginAttemptsTable.id, id),
      (LoginAttemptsTable.userId, userId),
      (LoginAttemptsTable.email, email),
      (LoginAttemptsTable.result, result),
      (LoginAttemptsTable.ipAddress, ipAddress),
      (LoginAttemptsTable.userAgent, userAgent),
      (LoginAttemptsTable.createdAt, createdAt),
    ]);
  }
}

/// Generated row mapping for the `login_attempts` table.
/// Represents a full-row result where all columns are expected to be present.
///
/// This model assumes SELECT queries include all columns defined in the table (i.e., `SELECT * FROM login_attempts`).
/// Partial SELECT projections are **not** supported and may result in runtime errors.
@immutable
final class LoginAttemptsRow {
  const LoginAttemptsRow({
    required this.id,
    required this.userId,
    required this.email,
    required this.result,
    required this.ipAddress,
    required this.userAgent,
    required this.createdAt,
  });

  factory LoginAttemptsRow.fromMap(Map<String, Object?> map) =>
      LoginAttemptsRow(
        id: (map[LoginAttemptsTable.id]! as int),
        userId: (map[LoginAttemptsTable.userId] as String?),
        email: (map[LoginAttemptsTable.email]! as String),
        result: (map[LoginAttemptsTable.result]! as String),
        ipAddress: (map[LoginAttemptsTable.ipAddress] as String?),
        userAgent: (map[LoginAttemptsTable.userAgent] as String?),
        createdAt: (map[LoginAttemptsTable.createdAt]! as DateTime),
      );

  final int id;

  final String? userId;

  final String email;

  /// Requires casting to TEXT when selecting this column (i..e, SELECT result::text)
  final String result;

  /// Requires casting to TEXT when selecting this column (i..e, SELECT ip_address::text)
  final String? ipAddress;

  final String? userAgent;

  final DateTime createdAt;
}

/// Generated mapping for the `role_permissions` table, providing type-safe references
/// for the table name and column names to avoid hardcoding strings.
abstract final class RolePermissionsTable {
  static const String tableName = 'role_permissions';

  static const String roleId = 'role_id';

  static const String permission = 'permission';

  static const List<String> columns = [roleId, permission];

  static Map<String, Object> insert({
    required int roleId,
    required String permission,
  }) => {
    RolePermissionsTable.roleId: roleId,
    RolePermissionsTable.permission: permission,
  };

  static Map<String, Object?> update({
    required Field<int> roleId,
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
        roleId: (map[RolePermissionsTable.roleId]! as int),
        permission: (map[RolePermissionsTable.permission]! as String),
      );

  final int roleId;

  /// Requires casting to TEXT when selecting this column (i..e, SELECT permission::text)
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
    int? id,
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
    Field<int> id = const .absent(),
    required Field<String> name,
    Field<DateTime> createdAt = const .absent(),
  }) {
    return _buildFieldMap([
      (RolesTable.id, id),
      (RolesTable.name, name),
      (RolesTable.createdAt, createdAt),
      (RolesTable.updatedAt, const .value('now()')),
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
    id: (map[RolesTable.id]! as int),
    name: (map[RolesTable.name]! as String),
    createdAt: (map[RolesTable.createdAt]! as DateTime),
    updatedAt: (map[RolesTable.updatedAt]! as DateTime),
  );

  final int id;

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
        version: (map[SchemaMigrationsTable.version]! as int),
        appliedAt: (map[SchemaMigrationsTable.appliedAt]! as DateTime),
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
        id: (map[UserRefreshTokensTable.id]! as int),
        userId: (map[UserRefreshTokensTable.userId]! as String),
        tokenHash: (map[UserRefreshTokensTable.tokenHash]! as String),
        deviceId: (map[UserRefreshTokensTable.deviceId] as String?),
        ipAddress: (map[UserRefreshTokensTable.ipAddress] as String?),
        userAgent: (map[UserRefreshTokensTable.userAgent] as String?),
        expiresAt: (map[UserRefreshTokensTable.expiresAt]! as DateTime),
        createdAt: (map[UserRefreshTokensTable.createdAt]! as DateTime),
      );

  final int id;

  final String userId;

  final String tokenHash;

  final String? deviceId;

  /// Requires casting to TEXT when selecting this column (i..e, SELECT ip_address::text)
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
    required int? roleId,
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
    required Field<int?> roleId,
    Field<DateTime> createdAt = const .absent(),
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
      (UsersTable.updatedAt, const .value('now()')),
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
    id: (map[UsersTable.id]! as String),
    email: (map[UsersTable.email]! as String),
    passwordHash: (map[UsersTable.passwordHash]! as String),
    tokenVersion: (map[UsersTable.tokenVersion]! as int),
    fullName: (map[UsersTable.fullName]! as String),
    phoneNumber: (map[UsersTable.phoneNumber] as String?),
    isSuperuser: (map[UsersTable.isSuperuser]! as bool),
    roleId: (map[UsersTable.roleId] as int?),
    createdAt: (map[UsersTable.createdAt]! as DateTime),
    updatedAt: (map[UsersTable.updatedAt]! as DateTime),
  );

  final String id;

  final String email;

  final String passwordHash;

  final int tokenVersion;

  final String fullName;

  final String? phoneNumber;

  final bool isSuperuser;

  final int? roleId;

  final DateTime createdAt;

  final DateTime updatedAt;
}
