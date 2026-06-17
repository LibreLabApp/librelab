import 'package:librelab_server/auth/login_attempt/login_attempt.dart';
import 'package:librelab_server/auth/login_attempt/login_attempt_repository.dart';
import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_schema.g.dart';
import 'package:librelab_server/database/utils/postgresql_utils.dart';

typedef _T = LoginAttemptsTable;

class PostgresLoginAttemptRepository implements LoginAttemptRepository {
  PostgresLoginAttemptRepository({required this._client});

  final DatabaseClient _client;

  @override
  Future<LoginAttempt> create({
    required String? userId,
    required String email,
    required LoginResult loginResult,
    required String? ipAddress,
    required String? userAgent,
  }) async {
    final Map<String, Object?> params = _T.insert(
      userId: userId,
      email: email,
      result: loginResult._toDto().text,
      ipAddress: ipAddress,
      userAgent: userAgent,
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
    final row = LoginAttemptsRow.fromMap(result.first.toColumnMap());
    return row._toDomain();
  }

  @override
  Future<void> deleteAll() async {
    await _client.execute(.new('TRUNCATE TABLE ${_T.tableName}'));
  }

  String get _selectColumns => _T.columns
      .map((e) {
        if (e == _T.ipAddress) {
          return castColumnToText(_T.ipAddress);
        }
        if (e == _T.result) {
          return castColumnToText(_T.result);
        }
        return e;
      })
      .join(', ');
}

extension on LoginResult {
  LoginResultPgEnum _toDto() => switch (this) {
    .success => .success,
    .invalidCredentials => .invalidCredentials,
    .validationError => .validationError,
    .userNotFound => .userNotFound,
    .locked => .locked,
    .loginDisabled => .loginDisabled,
    .rateLimited => .rateLimited,
  };
}

extension on LoginResultPgEnum {
  LoginResult _toDomain() => switch (this) {
    .success => .success,
    .invalidCredentials => .invalidCredentials,
    .validationError => .validationError,
    .userNotFound => .userNotFound,
    .locked => .locked,
    .loginDisabled => .loginDisabled,
    .rateLimited => .rateLimited,
  };
}

extension on LoginAttemptsRow {
  LoginAttempt _toDomain() => .new(
    id: id,
    userId: userId,
    email: email,
    result: LoginResultPgEnum.fromText(result)._toDomain(),
    ipAddress: ipAddress,
    userAgent: userAgent,
    createdAt: createdAt,
  );
}
