import 'package:meta/meta.dart';

@immutable
class const DatabaseMigration({
  required final int version,
  required final String sql,
});
