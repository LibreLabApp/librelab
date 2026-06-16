import 'package:librelab_server/auth/refresh_token/user_refresh_token.dart';
import 'package:librelab_server/auth/refresh_token/user_refresh_token_repository.dart';
import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_schema.g.dart';

typedef _T = UserRefreshTokensTable;

class PostgresUserRefreshTokenRepository implements UserRefreshTokenRepository {
  PostgresUserRefreshTokenRepository({required this._client});

  final DatabaseClient _client;

  @override
  Future<UserRefreshToken> create({
    required String userId,
    required String tokenHash,
    required UserRefreshTokenClientMetadata clientMetadata,
    required DateTime expiresAt,
  }) async {
    final Map<String, Object?> params = _T.insert(
      userId: userId,
      tokenHash: tokenHash,
      deviceId: clientMetadata.deviceId,
      ipAddress: clientMetadata.ipAddress,
      userAgent: clientMetadata.userAgent,
      expiresAt: expiresAt,
    );
    final result = await _client.execute(
      .named('''
INSERT INTO ${_T.tableName}
(${params.keys.join(', ')})
VALUES (${params.keys.map((key) => '@$key').join(', ')})
RETURNING $_selectColumns
'''),
      parameters: params,
    );
    final row = UserRefreshTokensRow.fromMap(result.first.toColumnMap());
    return row._toDomain();
  }

  @override
  Future<UserRefreshToken?> findByTokenHash(String tokenHash) async {
    final result = await _client.execute(
      .named('''
SELECT $_selectColumns FROM ${_T.tableName}
WHERE ${_T.tokenHash} = @tokenHash
LIMIT 1
'''),
      parameters: {'tokenHash': tokenHash},
    );
    final row = result.firstOrNull;
    if (row == null) {
      return null;
    }
    return UserRefreshTokensRow.fromMap(row.toColumnMap())._toDomain();
  }

  @override
  Future<List<UserRefreshToken>> findRefreshTokensByUserId(
    String userId,
  ) async {
    final result = await _client.execute(
      .named('''
SELECT $_selectColumns FROM ${_T.tableName}
WHERE ${_T.userId} = @userId
'''),
      parameters: {'userId': userId},
    );
    return result
        .map(
          (row) => UserRefreshTokensRow.fromMap(row.toColumnMap())._toDomain(),
        )
        .toList();
  }

  @override
  Future<bool> deleteById(int id) async {
    final result = await _client.execute(
      .named('''
DELETE FROM ${_T.tableName}
WHERE ${_T.id} = @id
RETURNING ${_T.id}
'''),
      parameters: {'id': id},
    );
    return result.isNotEmpty;
  }

  @override
  Future<bool> deleteByTokenHash(String tokenHash) async {
    final result = await _client.execute(
      .named('''
DELETE FROM ${_T.tableName}
WHERE ${_T.tokenHash} = @tokenHash
RETURNING ${_T.id}
'''),
      parameters: {'tokenHash': tokenHash},
    );
    return result.isNotEmpty;
  }

  @override
  Future<int> deleteRefreshTokensByUserId(String userId) async {
    final result = await _client.execute(
      .named('''
DELETE FROM ${_T.tableName}
WHERE ${_T.userId} = @userId
RETURNING ${_T.id}
'''),
      parameters: {'userId': userId},
    );
    return result.length;
  }

  @override
  Future<int> deleteExpiredRefreshTokens() async {
    final result = await _client.execute(
      .new('''
DELETE FROM ${_T.tableName}
WHERE ${_T.expiresAt} < now()
RETURNING ${_T.id}
'''),
    );
    return result.length;
  }

  String get _selectColumns => _T.columns
      .map((e) {
        if (e == _T.ipAddress) {
          return '${_T.ipAddress}::text AS ${_T.ipAddress}';
        }
        return e;
      })
      .join(', ');
}

extension on UserRefreshTokensRow {
  UserRefreshToken _toDomain() => UserRefreshToken(
    id: id,
    userId: userId,
    tokenHash: tokenHash,
    clientMetadata: UserRefreshTokenClientMetadata(
      deviceId: deviceId,
      ipAddress: ipAddress,
      userAgent: userAgent,
    ),
    createdAt: createdAt,
    expiresAt: expiresAt,
  );
}
