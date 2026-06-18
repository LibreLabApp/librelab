import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_migration.dart';
import 'package:logging/logging.dart';

class DatabaseMigrationRunner {
  DatabaseMigrationRunner({
    required this._client,
    required this._migrations,
    required this._latestVersion,
    required this._logger,
  });

  final DatabaseClient _client;
  final List<DatabaseMigration> _migrations;
  final int _latestVersion;
  final Logger _logger;

  // Note: Avoid depending on generated code in this file.
  // Instead hardcode table and column names
  static const String _tableName = 'schema_migrations';
  static const String _versionColumn = 'version';
  static const String _appliedAtColumn = 'applied_at';

  static const int _defaultVersion = 0;

  /// Returns current migration version.
  ///
  /// - `null` if migrations table does not exist
  /// - [_defaultVersion] if table exists but has no rows
  Future<int?> _getCurrentVersion() async {
    try {
      final result = await _client.execute(
        Sql('SELECT MAX($_versionColumn) as current_version FROM $_tableName'),
      );
      final value = result.first[0];
      if (value == null) {
        return _defaultVersion;
      }
      if (value is! int) {
        throw StateError(
          'Invalid migration version type: expected int, got ${value.runtimeType}',
        );
      }
      return value;
    } on ServerException catch (e) {
      // Throws when table is undefined: Severity.error 42P01: relation "..." does not exist
      final isUndefinedTable = e.code == '42P01';
      if (isUndefinedTable) {
        return null;
      }
      rethrow;
    }
  }

  Future<void> _createTable() async {
    await _client.execute(
      Sql('''
CREATE TABLE $_tableName (
  $_versionColumn INTEGER PRIMARY KEY,
  $_appliedAtColumn TIMESTAMP NOT NULL DEFAULT now()
)
'''),
    );
  }

  Future<int> _getOrCreateCurrentVersion() async {
    final existingVersion = await _getCurrentVersion();
    if (existingVersion == null) {
      await _createTable();
      return _defaultVersion;
    }
    return existingVersion;
  }

  Future<void> run() async {
    final currentVersion = await _getOrCreateCurrentVersion();

    if (currentVersion > _latestVersion) {
      _logger.shout(
        'The database migration version is $currentVersion, but this '
        'server only supports migrations up to version $_latestVersion.\n'
        'This usually indicates that the server was downgraded after the '
        'database was migrated by a newer version. The application may not '
        'function correctly.',
      );
    }

    final pending =
        _migrations
            .where((migration) => migration.version > currentVersion)
            .toList()
          ..sort((a, b) => a.version.compareTo(b.version));

    if (pending.isEmpty) {
      _logger.info('No migrations to apply');
      return;
    }

    for (final migration in pending) {
      _logger.info('Applying migration ${migration.version}...');

      await _client.transaction((tx) async {
        await tx.execute(
          Sql(migration.sql),
          // Allows multi-statements
          queryMode: .simple,
        );
        await tx.execute(
          Sql.named(
            'INSERT INTO $_tableName ($_versionColumn) VALUES (@version)',
          ),
          parameters: {'version': migration.version},
        );
      });
    }

    _logger.info('All database migrations have been applied');
  }
}
