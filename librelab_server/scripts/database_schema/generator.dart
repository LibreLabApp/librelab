import 'dart:collection';
import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';
import '../../../scripts/_utils.dart';

class Config {
  const Config({required this.input, required this.dartOutput});

  final Endpoint input;
  final String dartOutput;
}

Future<void> generate(Config config) async {
  final outputFile = File(config.dartOutput);
  if (!outputFile.existsSync()) {
    stderr.writeln('An empty file must exist: ${config.dartOutput}');
    exit(1);
  }

  final tables = await _readSchemaTablesFromDatabase(config.input);

  final generatedCode = _generateDartCode(UnmodifiableListView(tables));

  await outputFile.writeAsString(generatedCode);

  stdout.writeln('Generated ${config.dartOutput}.');
}

String _generateDartCode(UnmodifiableListView<_TableInfo> tables) {
  final classes = <Class>[];

  for (final table in tables) {
    final tableName = table.tableName;

    final tableNamePascalCase = snakeToPascalCase(tableName);
    final tableClassName = '${tableNamePascalCase}Table';

    final tableClass = Class(
      (b) => b
        ..name = tableClassName
        ..abstract = true
        ..modifier = ClassModifier.final$
        ..constructors.clear()
        ..fields.add(
          Field(
            (b) => b
              ..name = 'tableName'
              ..static = true
              ..modifier = FieldModifier.constant
              ..type = refer('String')
              ..assignment = literalString(tableName).code,
          ),
        )
        ..fields.addAll(
          table.columns
              .map(
                (e) => Field(
                  (b) => b
                    ..name = snakeToCamel(e.columnName)
                    ..static = true
                    ..modifier = FieldModifier.constant
                    ..type = refer('String')
                    ..assignment = literalString(e.columnName).code,
                ),
              )
              .toList(),
        )
        ..fields.add(
          Field(
            (b) => b
              ..name = 'columns'
              ..static = true
              ..modifier = FieldModifier.constant
              ..type = refer('List<String>')
              ..assignment = literalConstList(
                table.columns
                    .map((e) => Code(snakeToCamel(e.columnName)))
                    .toList(),
              ).code,
          ),
        )
        ..docs.addAll([
          '/// Generated mapping for the `$tableName` table, providing type-safe references',
          '/// for the table name and column names to avoid hardcoding strings.',
        ]),
    );

    final rowClassName = '${tableNamePascalCase}Row';
    final rowClass = Class(
      (b) => b
        ..name = rowClassName
        ..modifier = ClassModifier.final$
        ..docs.addAll([
          '/// Generated row mapping for the `$tableName` table.',
          '/// Represents a full-row result where all columns are expected to be present.',
          '///',
          '/// This model assumes SELECT queries include all columns defined in the table (i.e., `SELECT * FROM $tableName`).',
          '/// Partial SELECT projections are **not** supported and may result in runtime errors.',
        ])
        ..fields.addAll(
          table.columns.map((e) {
            return Field(
              (b) => b
                ..name = snakeToCamel(e.columnName)
                ..modifier = FieldModifier.final$
                ..type = refer(e.asDartType()),
            );
          }).toList(),
        )
        ..constructors.add(
          Constructor(
            (b) => b
              ..constant = true
              ..optionalParameters.addAll(
                table.columns.map(
                  (e) => Parameter(
                    (b) => b
                      ..name = snakeToCamel(e.columnName)
                      ..named = true
                      ..toThis = true
                      ..required = true,
                  ),
                ),
              ),
          ),
        )
        ..constructors.add(
          Constructor(
            (b) => b
              ..name = 'fromMap'
              ..factory = true
              ..requiredParameters.add(
                Parameter(
                  (b) => b
                    ..name = 'map'
                    ..type = refer('Map<String, Object?>'),
                ),
              )
              ..body = refer(rowClassName).newInstance([], {
                for (final e in table.columns)
                  snakeToCamel(e.columnName): refer('map')
                      .index(
                        refer(
                          tableClassName,
                        ).property(snakeToCamel(e.columnName)),
                      )
                      .nullChecked
                      .asA(refer(e.asDartType())),
              }).code,
          ),
        )
        ..annotations.add(refer('immutable')),
    );

    classes.addAll([tableClass, rowClass]);
  }

  final emitter = DartEmitter();

  final library = Library(
    (b) => b
      ..directives.add(Directive.import('package:meta/meta.dart'))
      ..docs.addAll([
        '// coverage:ignore-file',
        '/// Generated code. Do not modify directly.',
        '/// Instead, modify and then run: dart $scriptRelativePath',
      ])
      ..body.addAll(classes),
  );

  return DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  ).format('${library.accept(emitter)}');
}

Future<List<_TableInfo>> _readSchemaTablesFromDatabase(
  Endpoint endpoint,
) async {
  final connection = await Connection.open(
    endpoint,
    settings: const ConnectionSettings(sslMode: .disable),
  );

  try {
    final tables = await _readSchemaTables(connection);

    return tables;
  } finally {
    await connection.close();
  }
}

Future<List<_TableInfo>> _readSchemaTables(Connection connection) async {
  final tables = <_TableInfo>[];
  final tablesResult = await connection.execute(
    Sql.named('''
      SELECT table_name
      FROM information_schema.tables
      WHERE table_schema = 'public'
      ORDER BY table_name;
    '''),
  );

  for (final tableRow in tablesResult) {
    final tableName = tableRow[0]! as String;

    final columnsResult = await connection.execute(
      Sql.named('''
SELECT column_name, data_type, udt_name, is_nullable
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = @table
        ORDER BY ordinal_position;
      '''),
      parameters: {'table': tableName},
    );

    final columns = columnsResult
        .map((row) => _TableColumnInfo.fromMap(row.toColumnMap()))
        .toList();

    final table = _TableInfo(tableName: tableName, columns: columns);
    tables.add(table);
  }

  return tables;
}

@immutable
class _TableInfo {
  const _TableInfo({required this.tableName, required this.columns});

  final String tableName;
  final List<_TableColumnInfo> columns;

  @override
  String toString() => 'TableInfo(tableName: $tableName, columns: $columns)';
}

@immutable
class _TableColumnInfo {
  const _TableColumnInfo({
    required this.columnName,
    required this.dataType,
    required this.udtName,
    required this.isNullable,
  });

  factory _TableColumnInfo.fromMap(Map<String, Object?> map) {
    final rawNullable = map['is_nullable']! as String;

    return _TableColumnInfo(
      columnName: map['column_name']! as String,
      dataType: map['data_type']! as String,
      udtName: map['udt_name']! as String,
      isNullable: switch (rawNullable) {
        'YES' => true,
        'NO' => false,
        String() => throw StateError(
          'Unexpected is_nullable value: $rawNullable',
        ),
      },
    );
  }

  final String columnName;
  final String dataType;
  final String udtName;
  final bool isNullable;

  @override
  String toString() =>
      'TableColumnInfo(columnName: $columnName, dataType: $dataType, udtName: $udtName, isNullable: $isNullable)';

  String asDartType() {
    // Handles PostgreSQL enums
    if (dataType == 'USER-DEFINED') {
      return 'String';
    }
    final type = switch (udtName) {
      'int4' => 'int',
      'uuid' => 'String',
      'text' => 'String',
      'timestamp' => 'DateTime',
      'timestamptz' => 'DateTime',
      'bool' => 'bool',
      String() => throw StateError(
        'Unexpected udt_name value for column "$columnName": $udtName (Human readable name: $dataType)',
      ),
    };
    return type + (isNullable ? '?' : '');
  }
}
