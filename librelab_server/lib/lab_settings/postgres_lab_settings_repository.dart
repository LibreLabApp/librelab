import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_schema.g.dart';
import 'package:librelab_server/lab_settings/lab_settings.dart';
import 'package:librelab_server/lab_settings/lab_settings_repository.dart';
import 'package:optional_field/optional_field.dart';

typedef _T = LabSettingsTable;
typedef _Row = LabSettingsRow;

class PostgresLabSettingsRepository implements LabSettingsRepository {
  PostgresLabSettingsRepository({required this._client});

  final DatabaseClient _client;

  LabSettings? _cached;

  // Singleton
  static const _id = 1;

  @override
  Future<LabSettings> upsert(LabSettingsPatch patch) async {
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

    final row = LabSettingsRow.fromMap(result.first.toColumnMap());

    final settings = row._toDomain();
    _cached = settings;

    return settings;
  }

  @override
  Future<LabSettings?> load() async {
    final result = await _client.execute(
      .named('SELECT * FROM ${_T.tableName} WHERE ${_T.id} = @id'),
      parameters: {'id': _id},
    );

    final row = result.firstOrNull;
    if (row == null) {
      return null;
    }

    final settings = _Row.fromMap(row.toColumnMap())._toDomain();
    _cached = settings;

    return settings;
  }

  @override
  LabSettings get cached =>
      _cached ?? (throw StateError('$LabSettings are not loaded yet.'));
}

extension on _Row {
  LabSettings _toDomain() =>
      LabSettings(labName: labName, loginDisabled: loginDisabled);
}
