import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

enum Permission { backupCreate, backupRestore, labSettingsUpdate }

@immutable
class const Role({
  required final int id,
  required final String name,
  required final List<Permission> permissions,
  required final DateTime createdAt,
  required final DateTime updatedAt,
}) {
  @override
  String toString() =>
      'Role(id: $id, name: $name, permissions: $permissions, createdAt: $createdAt, updatedAt: $updatedAt)';
}

@immutable
class const RoleCreate({
  required final String name,
  required final List<Permission> permissions,
});

@immutable
class const RolePatch({
  final Field<String> name = const .absent(),
  final Field<List<Permission>> permissions = const .absent(),
});
