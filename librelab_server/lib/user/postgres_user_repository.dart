import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_schema.g.dart';
import 'package:librelab_server/database/utils/prefixed_column_projection.dart';
import 'package:librelab_server/user/role/role.dart';
import 'package:librelab_server/user/user.dart';
import 'package:librelab_server/user/user_repository.dart';

typedef _U = UsersTable;
typedef _R = RolesTable;
typedef _Rp = RolePermissionsTable;

const _rolePermissionsAlias = 'role_permissions';

class PostgresUserRepository implements UserRepository {
  PostgresUserRepository({required this._client});

  final DatabaseClient _client;

  @override
  Future<List<User>> findAll() => _find(where: null);

  @override
  Future<User?> findById(String id) => _findOne(by: .id, value: id);

  @override
  Future<User?> findByEmail(String email) => _findOne(by: .email, value: email);

  @override
  Future<int?> findTokenVersionById(String id) async {
    final result = await _client.execute(
      .named('''
SELECT ${_U.tokenVersion} FROM ${_U.tableName}
WHERE ${_U.id} = @id
'''),
      parameters: {'id': id},
    );
    final row = result.firstOrNull;
    if (row == null) {
      return null;
    }
    return row[0]! as int;
  }

  @override
  Future<AuthUser?> findAuthUserById(String id) async {
    final result = await _client.execute(
      .named('''
SELECT u.${_U.tokenVersion}, u.${_U.isSuperuser}, array_agg(rp.${_Rp.permission}::text) AS $_rolePermissionsAlias
FROM ${_U.tableName} u
LEFT JOIN ${_Rp.tableName} rp ON rp.${_Rp.roleId} = u.${_U.roleId}
WHERE u.${_U.id} = @id
GROUP BY u.${_U.id}
LIMIT 1
'''),
      parameters: {'id': id},
    );
    final row = result.firstOrNull;
    if (row == null) {
      return null;
    }

    final map = row.toColumnMap();
    return AuthUser(
      id: id,
      tokenVersion: map[_U.tokenVersion] as int,
      isSuperUser: map[_U.isSuperuser] as bool,
      permissions: _mapRolePermissionsFromRow(map),
    );
  }

  Future<User?> _findOne({
    required _UserIdentifier by,
    required String value,
  }) async {
    final result = await _find(where: (by, value));
    return result.firstOrNull;
  }

  Future<List<User>> _find({required (_UserIdentifier, String)? where}) async {
    const roleProjection = PrefixedColumnProjection(
      tableAlias: 'r',
      prefix: 'role_',
      columns: _R.columns,
    );

    const rolePermissionsAlias = 'role_permissions';

    final result = await _client.execute(
      .named('''
SELECT
  u.*,
  ${roleProjection.build()},
  array_agg(rp.${_Rp.permission}::text) AS $rolePermissionsAlias
FROM ${_U.tableName} u
LEFT JOIN ${_R.tableName} r ON r.${_R.id} = u.${_U.roleId}
LEFT JOIN ${_Rp.tableName} rp ON rp.${_Rp.roleId} = r.${_R.id}
${where != null ? 'WHERE u.${where.$1.columnName} = @v' : ''}
GROUP BY u.${_U.id}, r.${_R.id}
${where != null ? 'LIMIT 1' : ''}
'''),
      parameters: where != null ? {'v': where.$2} : null,
    );

    return result.map((row) {
      final map = row.toColumnMap();

      final userRow = UsersRow.fromMap(map);

      return userRow._toDomain(
        role: () => RolesRow.fromMap(roleProjection.stripPrefix(map))._toDomain(
          // Can be List<String?> in case there are no permissions for this role
          permissions: () => _mapRolePermissionsFromRow(map),
        ),
      );
    }).toList();
  }

  @override
  Future<bool> isEmailUsed(String email) async {
    final result = await _client.execute(
      .named('''
SELECT EXISTS (
  SELECT 1
  FROM ${_U.tableName}
  WHERE ${_U.email} = @email
)
'''),
      parameters: {'email': email},
    );
    return result.first[0]! as bool;
  }

  @override
  Future<User> create({
    required String email,
    required String passwordHash,
    required String fullName,
    required String? phoneNumber,
    required UserType type,
  }) async {
    final (bool isSuperUser, String? roleId) = switch (type) {
      RegularUserType(:final roleId) => (false, roleId),
      SuperUserType() => (true, null),
    };

    final id = await _insertUser(
      email: email,
      passwordHash: passwordHash,
      fullName: fullName,
      phoneNumber: phoneNumber,
      isSuperUser: isSuperUser,
      roleId: roleId,
    );
    return (await _findOne(by: .id, value: id))!;
  }

  /// Returns the ID of the inserted user
  Future<String> _insertUser({
    required String email,
    required String passwordHash,
    required String fullName,
    required String? phoneNumber,
    required bool isSuperUser,
    required String? roleId,
  }) async {
    if (isSuperUser && roleId != null) {
      throw ArgumentError('A superuser cannot have a role');
    }
    if (!isSuperUser && roleId == null) {
      throw ArgumentError('A non-superuser needs a role');
    }

    final Map<String, Object?> params = _U.insert(
      email: email,
      passwordHash: passwordHash,
      fullName: fullName,
      phoneNumber: phoneNumber,
      isSuperuser: isSuperUser,
      roleId: roleId,
    );

    final result = await _client.execute(
      .named('''
INSERT INTO ${_U.tableName}
(${params.keys.join(', ')})
VALUES (${params.keys.map((key) => '@$key').join(', ')})
RETURNING ${_U.id}
'''),
      parameters: {...params},
    );

    final id = result.first.first! as String;
    return id;
  }

  @override
  Future<bool> delete(String id) async {
    final result = await _client.execute(
      .named('''
DELETE FROM ${_U.tableName}
WHERE ${_U.id} = @id
RETURNING ${_U.id}
'''),
      parameters: {'id': id},
    );
    return result.isNotEmpty;
  }

  @override
  Future<User?> update(String id, UserPatch patch) async {
    final Map<String, Object?> params = _U.update(
      email: patch.email,
      passwordHash: patch.passwordHash,
      tokenVersion: patch.tokenVersion,
      fullName: patch.fullName,
      phoneNumber: patch.phoneNumber,
      isSuperuser: const .absent(),
      roleId: patch.roleId,
    );

    final result = await _client.execute(
      .named('''
UPDATE ${_U.tableName}
SET ${params.keys.map((key) => '$key = @$key').join(', ')}
WHERE ${_U.id} = @id
RETURNING ${_U.id}
'''),
      parameters: {'id': id, ...params},
    );
    if (result.isEmpty) {
      // User was not found
      return null;
    }

    final updatedUser = await _findOne(by: .id, value: id);
    return updatedUser;
  }
}

enum _UserIdentifier {
  email(columnName: _U.email),
  id(columnName: _U.id);

  const _UserIdentifier({required this.columnName});

  final String columnName;
}

extension on UsersRow {
  User _toDomain({required Role Function() role}) {
    return User(
      id: id,
      email: email,
      passwordHash: passwordHash,
      tokenVersion: tokenVersion,
      fullName: fullName,
      isSuperUser: isSuperuser,
      role: isSuperuser ? null : role(),
      phoneNumber: phoneNumber,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension on RolesRow {
  Role _toDomain({required List<Permission> Function() permissions}) {
    return Role(
      id: id,
      name: name,
      permissions: permissions(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension on PermissionPgEnum {
  Permission _toDomain() => switch (this) {
    .backupCreate => .backupCreate,
    .backupRestore => .backupRestore,
  };
}

List<Permission> _mapRolePermissionsFromRow(Map<String, Object?> map) {
  return (map[_rolePermissionsAlias]! as List<String?>).nonNulls
      .map(PermissionPgEnum.fromText)
      .map<Permission>((e) => e._toDomain())
      .toList();
}
