import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

enum Permission { backupCreate, backupRestore, labSettingsUpdate }

@immutable
class Role {
  Role({
    required this.id,
    required this.name,
    required List<Permission> permissions,
    required this.createdAt,
    required this.updatedAt,
  }) : permissions = List.unmodifiable(permissions);

  final int id;
  final String name;
  final List<Permission> permissions;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  String toString() =>
      'Role(id: $id, name: $name, permissions: $permissions, createdAt: $createdAt, updatedAt: $updatedAt)';
}

@immutable
class RoleCreate {
  const RoleCreate({required this.name, required this.permissions});

  final String name;
  final List<Permission> permissions;
}

@immutable
class RolePatch {
  const RolePatch({
    this.name = const .absent(),
    this.permissions = const .absent(),
  });

  final Field<String> name;
  final Field<List<Permission>> permissions;
}
