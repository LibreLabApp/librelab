import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_schema.g.dart';
import 'package:librelab_server/settings/app_settings.dart';
import 'package:librelab_server/settings/app_settings_repository.dart';
import 'package:optional_field/optional_field.dart';

typedef _T = AppSettingsTable;

class PostgresAppSettingsRepository implements AppSettingsRepository {
  PostgresAppSettingsRepository({required this._client});

  final DatabaseClient _client;

  AppSettings? _cached;

  // Singleton
  static const _id = 1;

  @override
  Future<AppSettings> upsert(AppSettingsPatch patch) async {
    final params = _T.update(
      id: const Field.value(_id),
      labName: patch.labName,
      loginDisabled: patch.loginDisabled,
    );

    final result = await _client.execute(
      .named('''
INSERT INTO ${_T.tableName} (${params.keys.join(', ')})
VALUES (${params.keys.map((key) => '@$key').join(', ')})
ON CONFLICT (${_T.id})
DO UPDATE SET
  ${params.keys.map((key) => '$key = EXCLUDED.$key').join(', ')}
RETURNING *
'''),
      parameters: params,
    );

    final row = AppSettingsRow.fromMap(result.first.toColumnMap());

    final appSettings = row._toDomain();
    _cached = appSettings;

    return appSettings;
  }

  @override
  Future<AppSettings?> load() async {
    final result = await _client.execute(
      .named('SELECT * FROM ${_T.tableName} WHERE ${_T.id} = @id'),
      parameters: {'id': _id},
    );

    final row = result.firstOrNull;
    if (row == null) {
      return null;
    }

    final appSettings = AppSettingsRow.fromMap(row.toColumnMap())._toDomain();
    _cached = appSettings;

    return appSettings;
  }

  @override
  AppSettings get cached =>
      _cached ?? (throw StateError('App settings are not loaded yet.'));
}

extension on AppSettingsRow {
  AppSettings _toDomain() =>
      AppSettings(labName: labName, loginDisabled: loginDisabled);
}
