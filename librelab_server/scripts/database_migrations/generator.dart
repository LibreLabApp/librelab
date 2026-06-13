import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:librelab_server/database/database_migration.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import '../../../scripts/_utils.dart';

const String _databaseMigrationClassName = 'DatabaseMigration';

@immutable
class Config {
  const Config({
    required this.input,
    required this.dartOutput,
    required this.outputClassName,
    required this.requiredTypesImport,
  });

  final String input;
  final String dartOutput;
  final String outputClassName;

  /// The import that provides [DatabaseMigration]
  final String requiredTypesImport;
}

Future<void> generate(Config config) async {
  final outputFile = File(config.dartOutput);
  if (!outputFile.existsSync()) {
    stderr.writeln('An empty file must exist: ${config.dartOutput}');
    exit(1);
  }

  final migrationsDir = Directory(config.input);
  if (!migrationsDir.existsSync()) {
    stderr.writeln('Migration directory does not exist: ${migrationsDir.path}');
    exit(1);
  }

  final migrations = <DatabaseMigration>[];

  await for (final entity in migrationsDir.list(recursive: false)) {
    if (entity is! File || !entity.path.endsWith('.sql')) {
      continue;
    }

    final migrationFile = entity;

    final fileName = p.basenameWithoutExtension(migrationFile.path);
    final version = int.tryParse(fileName);
    if (version == null) {
      stderr.writeln(
        'Invalid migration filename: ${migrationFile.path}\n'
        'Expected format: <integer>.sql (e.g. 1.sql, 42.sql)\n'
        'Received basename: $fileName',
      );
      exit(1);
    }

    migrations.add(
      DatabaseMigration(
        version: version,
        sql: await migrationFile.readAsString(),
      ),
    );
  }

  if (migrations.isEmpty) {
    stderr.writeln('No migration files detected');
    exit(1);
  }

  // For readability reasons only.
  // Consumers should not depend on the order of the generated code.
  migrations.sort((a, b) => a.version.compareTo(b.version));

  final generatedCode = _generateDartCode(.unmodifiable(migrations), config);

  await outputFile.writeAsString(generatedCode);

  stdout.writeln('Generated ${config.dartOutput}.');
}

String _generateDartCode(List<DatabaseMigration> migrations, Config config) {
  final generatedMigrations = _buildMigrationsListExpression(migrations);

  final generatedClass = Class(
    (b) => b
      ..name = config.outputClassName
      ..abstract = true
      ..modifier = ClassModifier.final$
      ..constructors.clear()
      ..fields.add(
        Field(
          (b) => b
            ..name = 'list'
            ..modifier = .final$
            ..static = true
            ..type = refer('List<$_databaseMigrationClassName>')
            ..assignment = generatedMigrations.code,
        ),
      )
      ..fields.add(
        Field(
          (b) => b
            ..name = 'latest'
            ..modifier = .final$
            ..static = true
            ..type = refer('int')
            ..assignment = literalNum(migrations.last.version).code,
        ),
      )
      ..docs.addAll([
        '/// Generated code. Do not **modify** directly.',
        '///',
        '/// Database migration scripts.',
        '/// This approach avoids reading system files at runtime,',
        '/// which is error-prone, can be deleted by the user, and is harder to bundle.',
      ]),
  );

  final emitter = DartEmitter();

  final library = Library(
    (b) => b
      ..directives.add(Directive.import(config.requiredTypesImport))
      ..docs.addAll([
        '// coverage:ignore-file',
        '/// Generated code. Do not modify directly.',
        '/// Instead, modify and then run: dart $scriptRelativePath',
      ])
      ..body.addAll([generatedClass]),
  );

  return DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  ).format('${library.accept(emitter)}');
}

Expression _buildMigrationsListExpression(
  Iterable<DatabaseMigration> migrations,
) {
  return literalConstList(
    migrations.map((migration) {
      return refer(_databaseMigrationClassName).newInstance([], {
        'version': literalNum(migration.version),
        // Allows using $ in .sql files
        'sql': literalString(migration.sql.replaceAll(r'$', r'\$')),
      });
    }).toList(),
  );
}
