/// @docImport 'package:postgres/postgres.dart';
library;

import 'package:meta/meta.dart';

/// Builds a SQL column projection for JOIN queries where all columns from a table
/// are selected and prefixed to avoid name collisions when parsing via column names.
///
/// Example:
///
/// ```dart
/// const roleProjection = PrefixedColumnProjection(
///   tableAlias: 'r', // The table name or alias
///   prefix: 'role_', // The desired prefix
///   columns: RolesTable.columns, // Column names
/// );
///
/// final output = roleProjection.build();
///
/// print(output); // r.id AS role_id, r.name AS role_name
///
/// // Use the output to build SQL query.
/// ```
@immutable
class PrefixedColumnProjection {
  const PrefixedColumnProjection({
    required this.tableAlias,
    required this.prefix,
    required this.columns,
  });

  final String tableAlias;
  final String prefix;
  final List<String> columns;

  String build() {
    final buffer = StringBuffer();

    for (var i = 0; i < columns.length; i++) {
      final column = columns[i];

      buffer.write('$tableAlias.$column AS $prefix$column');

      if (i < columns.length - 1) {
        buffer.write(', ');
      }
    }

    return buffer.toString();
  }

  /// Removes entries whose keys do not start with [prefix], then strips [prefix]
  /// from the remaining keys.
  ///
  /// Example:
  /// [prefix]_id -> id
  /// [prefix]_name -> name
  ///
  /// Useful when using [ResultRow.toColumnMap]
  Map<String, Object?> stripPrefix(Map<String, Object?> map) {
    return Map.fromEntries(
      map.entries
          .where((e) => e.key.startsWith(prefix))
          .map(
            (entry) =>
                MapEntry(entry.key.replaceFirst(prefix, ''), entry.value),
          ),
    );
  }
}
