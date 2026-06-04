import 'package:meta/meta.dart';

@immutable
class DatabaseMigration {
  const DatabaseMigration({required this.version, required this.sql});

  final int version;
  final String sql;
}
