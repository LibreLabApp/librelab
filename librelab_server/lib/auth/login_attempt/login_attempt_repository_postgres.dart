import 'package:librelab_server/auth/login_attempt/login_attempt.dart';
import 'package:librelab_server/auth/login_attempt/login_attempt_repository.dart';
import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_schema.g.dart';
import 'package:librelab_server/database/utils/postgresql_utils.dart';

typedef _T = LoginAttemptsTable;

class LoginAttemptRepositoryPostgres(final SqlDatabaseAccess _db)
    implements LoginAttemptRepository {
  @override
  Future<LoginAttempt> create(LoginAttemptCreate create) async {
    final Map<String, Object?> params = _T.insert(
      userId: create.userId,
      email: create.email,
      result: create.loginResult._toDto().text,
      ipAddress: create.ipAddress,
      userAgent: create.userAgent,
    );
    final result = await _db.execute('''
INSERT INTO ${_T.tableName}
(${params.keys.join(', ')})
VALUES (${params.keys.map((key) => '@$key').join(', ')})
RETURNING $_selectColumns
''', parameters: params);
    final row = LoginAttemptsRow.fromMap(result.first.toColumnMap());
    return row._toDomain();
  }

  @override
  Future<void> deleteAll() async {
    await _db.execute('TRUNCATE TABLE ${_T.tableName}', ignoreRows: true);
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
