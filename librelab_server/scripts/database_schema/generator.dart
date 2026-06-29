import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';
import '../../../scripts/_utils.dart';

@immutable
class const Config({
  required final Endpoint input,
  required final String dartOutput,
  required final List<String> optionalInsertColumns,
  required final List<String> optionalUpdateColumns,
  required final Map<String, String> updateColumnDefaults,
  required final List<(String, List<String>)> requiredTypeImports,
  required final Future<void> Function(Connection databaseConnection)
  applyMigrations,
});

Future<void> generate(Config config) async {
  final outputFile = File(config.dartOutput);
  if (!outputFile.existsSync()) {
    stderr.writeln('An empty file must exist: ${config.dartOutput}');
    exit(1);
  }

  final connection = await Connection.open(
    config.input,
    settings: const ConnectionSettings(sslMode: .disable),
  );

  try {
    await config.applyMigrations(connection);

    final (tables, enums) = await _readTypesFromDatabase(connection);

    final generatedCode = _generateDartCode(
      tables: List.unmodifiable(tables),
      pgEnums: List.unmodifiable(enums),
      optionalInsertColumns: config.optionalInsertColumns,
      optionalUpdateColumns: config.optionalUpdateColumns,
      updateColumnDefaults: config.updateColumnDefaults,
      requiredTypeImports: config.requiredTypeImports,
    );

    await outputFile.writeAsString(generatedCode);

    stdout.writeln('Generated ${config.dartOutput}.');
  } finally {
    await connection.close();
  }
}

String _generateDartCode({
  required List<_TableInfo> tables,
  required List<_PgEnum> pgEnums,
  required List<String> optionalInsertColumns,
  required List<String> optionalUpdateColumns,
  required Map<String, String> updateColumnDefaults,
  required List<(String, List<String>)> requiredTypeImports,
}) {
  final enums = <Enum>[];

  for (final pgEnum in pgEnums) {
    final generatedEnumName = _convertPgEnumNameToDartName(pgEnum.name);
    enums.add(
      Enum(
        (b) => b
          ..name = generatedEnumName
          ..fields.add(
            Field(
              (b) => b
                ..name = 'text'
                ..type = refer('String')
                ..modifier = FieldModifier.final$,
            ),
          )
          ..constructors.add(
            Constructor(
              (b) => b
                ..constant = true
                ..requiredParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'text'
                      ..toThis = true,
                  ),
                ),
            ),
          )
          ..values.addAll(
            pgEnum.values
                .map(
                  (value) => EnumValue(
                    (b) => b
                      ..name = snakeToCamel(value.replaceAll(':', '_'))
                      ..arguments.add(literalString(value)),
                  ),
                )
                .toList(),
          )
          ..methods.add(
            Method(
              (b) => b
                ..name = 'fromText'
                ..returns = refer(generatedEnumName)
                ..static = true
                ..requiredParameters.add(
                  Parameter(
                    (b) => b
                      ..name = 'value'
                      ..type = refer('String'),
                  ),
                )
                ..body = Block.of([
                  const Code('return values.firstWhere('),
                  const Code('(e) => e.text == value,'),
                  const Code(
                    r"orElse: () => throw ArgumentError('Unknown enum value: $value'),",
                  ),
                  const Code(');'),
                ]),
            ),
          )
          ..docs.addAll([
            '/// Generated enum from PostgreSQL enum `${pgEnum.name}`.',
          ]),
      ),
    );
  }

  final classes = <Class>[];

  for (final table in tables) {
    for (final column in table.columns) {
      final columnName = column.columnName;
      if (optionalUpdateColumns.contains(columnName) &&
          updateColumnDefaults.containsKey(columnName)) {
        throw ArgumentError(
          '$columnName must not exist in both optionalUpdateColumns and updateColumnDefaults',
        );
      }
    }
    final tableName = table.tableName;

    final tableNamePascalCase = snakeToPascalCase(tableName);
    final tableClassName = '${tableNamePascalCase}Table';

    final tableClass = Class(
      (b) => b
        ..name = tableClassName
        ..abstract = true
        ..modifier = ClassModifier.final$
        ..constructors.clear()
        ..methods.add(
          Method(
            (b) => b
              ..name = 'insert'
              ..returns = refer('Map<String, Object>')
              ..static = true
              ..optionalParameters.addAll(
                table.columns.map((e) {
                  final isOptional =
                      optionalInsertColumns.contains(e.columnName) ||
                      e.hasDefault;

                  return Parameter(
                    (b) => b
                      ..name = snakeToCamel(e.columnName)
                      ..named = true
                      ..required = !isOptional
                      ..type = refer(() {
                        final type = e.dartType();
                        if (isOptional && !e.isNullable) {
                          return '$type?';
                        }
                        return type;
                      }()),
                  );
                }).toList(),
              )
              ..body = literalMap(
                Map.fromEntries(
                  table.columns
                      .map(
                        (e) => MapEntry(
                          refer(
                            '$tableClassName.${snakeToCamel(e.columnName)}',
                          ),
                          () {
                            final isOptional =
                                optionalInsertColumns.contains(e.columnName) ||
                                e.hasDefault;
                            final parameterName = snakeToCamel(e.columnName);

                            if (e.isNullable || isOptional) {
                              return Code('?$parameterName');
                            }
                            return refer(parameterName);
                          }(),
                        ),
                      )
                      .toList(),
                ),
              ).code,
          ),
        )
        ..methods.add(
          Method(
            (b) => b
              ..name = 'update'
              ..returns = refer('Map<String, Object?>')
              ..static = true
              ..optionalParameters.addAll(
                table.columns
                    .where(
                      (e) => !updateColumnDefaults.containsKey(e.columnName),
                    )
                    .map((e) {
                      final isOptional = optionalUpdateColumns.contains(
                        e.columnName,
                      );
                      return Parameter(
                        (b) => b
                          ..name = snakeToCamel(e.columnName)
                          ..named = true
                          ..required = !isOptional
                          ..defaultTo = isOptional
                              ? const Code('const .absent()')
                              : null
                          ..type = refer('Field<${e.dartType()}>'),
                      );
                    })
                    .toList(),
              )
              ..body = Code('''
return _buildFieldMap([${table.columns.map((e) {
                final columnName = e.columnName;

                final expression = updateColumnDefaults.containsKey(columnName) ? "const .value('${updateColumnDefaults[columnName]}')" : snakeToCamel(columnName);

                return '($tableClassName.${snakeToCamel(columnName)}, $expression)';
              }).join(', ')}]);
'''),
          ),
        )
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
            return Field((b) {
              b
                ..name = snakeToCamel(e.columnName)
                ..modifier = FieldModifier.final$
                ..type = refer(e.dartType());
              if (e.resolveDartType().requiresTextCasting) {
                b.docs.add(
                  '/// Requires casting to TEXT when selecting this column (i..e, SELECT ${e.columnName}::text)',
                );
              }
            });
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
                  snakeToCamel(e.columnName): () {
                    final expression = refer('map').index(
                      refer(
                        tableClassName,
                      ).property(snakeToCamel(e.columnName)),
                    );
                    final expressionWithNullCheck = switch (e.isNullable) {
                      true => expression,
                      false => expression.nullChecked,
                    };

                    final dartType = e.dartType();
                    final expressionWithCast = expressionWithNullCheck.asA(
                      refer(dartType),
                    );

                    return expressionWithCast;
                  }(),
              }).code,
          ),
        )
        ..annotations.add(refer('immutable')),
    );

    classes.addAll([tableClass, rowClass]);
  }

  const buildFieldMap = Code(r'''
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
''');

  final emitter = DartEmitter();

  final library = Library(
    (b) => b
      ..directives.addAll(
        requiredTypeImports.map((e) => Directive.import(e.$1, show: e.$2)),
      )
      ..docs.addAll([
        '// coverage:ignore-file',
        '// ignore_for_file: unnecessary_parenthesis',
        '/// Generated code. Do not modify directly.',
        '/// Instead, modify and then run: dart $scriptRelativePath',
      ])
      ..body.addAll([buildFieldMap, ...enums, ...classes]),
  );

  return DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  ).format('${library.accept(emitter)}');
}

Future<(List<_TableInfo>, List<_PgEnum>)> _readTypesFromDatabase(
  Connection connection,
) async {
  final tables = await _readSchemaTables(connection);
  final enums = await _readEnums(connection);

  return (tables, enums);
}

Future<List<_TableInfo>> _readSchemaTables(Connection connection) async {
  final tables = <_TableInfo>[];
  final tablesResult = await connection.execute(
    Sql('''
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
SELECT column_name, data_type, udt_name, is_nullable,
(column_default IS NOT NULL) AS has_default
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = @table
        ORDER BY ordinal_position
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

Future<List<_PgEnum>> _readEnums(Connection connection) async {
  final enumRows = await connection.execute(
    Sql('''
SELECT
  t.typname AS enum_name,
  array_agg(e.enumlabel ORDER BY e.enumsortorder)::text[] AS enum_values
FROM pg_type t
JOIN pg_enum e ON e.enumtypid = t.oid
GROUP BY t.typname
ORDER BY t.typname;
'''),
  );

  return enumRows.map((e) => _PgEnum.fromMap(e.toColumnMap())).toList();
}

@immutable
class const _TableInfo({
  required final String tableName,
  required final List<_TableColumnInfo> columns,
}) {
  @override
  String toString() => 'TableInfo(tableName: $tableName, columns: $columns)';
}

@immutable
class const _TableColumnInfo({
  required final String columnName,
  required final String dataType,
  required final String udtName,
  required final bool isNullable,
  required final bool hasDefault,
}) {
  factory fromMap(Map<String, Object?> map) {
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
      hasDefault: map['has_default']! as bool,
    );
  }

  @override
  String toString() =>
      'TableColumnInfo(columnName: $columnName, dataType: $dataType, udtName: $udtName, isNullable: $isNullable, hasDefault: $hasDefault)';

  _DartType resolveDartType() {
    final isEnum = dataType == 'USER-DEFINED';
    if (isEnum) {
      // Handles PostgreSQL enums
      return _DartType(
        'String',
        requiresTextCasting: true,
        enumType: _convertPgEnumNameToDartName(udtName),
      );
    }
    final type = switch (udtName) {
      'int4' => const _DartType('int'),
      'int8' => const _DartType('int'),
      'inet' => const _DartType('String', requiresTextCasting: true),
      'uuid' => const _DartType('String'),
      'text' => const _DartType('String'),
      'timestamp' => const _DartType('DateTime'),
      'timestamptz' => const _DartType('DateTime'),
      'bool' => const _DartType('bool'),
      'jsonb' => const _DartType('JsonMap'),
      String() => throw StateError(
        'Unexpected udt_name value for column "$columnName": $udtName (Human readable name: $dataType)',
      ),
    };
    return type;
  }

  String dartType() {
    return resolveDartType().type + (isNullable ? '?' : '');
  }
}

@immutable
class const _PgEnum({
  required final String name,
  required final List<String> values,
}) {
  factory fromMap(Map<String, Object?> map) {
    return _PgEnum(
      name: map['enum_name']! as String,
      values: (map['enum_values']! as List<Object?>).cast<String>(),
    );
  }
}

String _convertPgEnumNameToDartName(String enumName) =>
    '${snakeToPascalCase(enumName)}PgEnum';

@immutable
class const _DartType(
  final String rawType, {

  /// Whether this type requires ::text casting in SQL select (e.g., SELECT column::text)
  final bool requiresTextCasting = false,
  final String? enumType,
}) {
  // TODO: Support enums
  // String get type => enumType ?? rawType;
  String get type => rawType;
}
