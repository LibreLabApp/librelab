import 'package:meta/meta.dart';

enum Permission { backupCreate, backupRestore }

@immutable
class Role {
  Role({
    required this.id,
    required this.name,
    required List<Permission> permissions,
    required this.createdAt,
    required this.updatedAt,
  }) : permissions = List.unmodifiable(permissions);

  final String id;
  final String name;
  final List<Permission> permissions;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  String toString() =>
      'Role(id: $id, name: $name, permissions: $permissions, createdAt: $createdAt, updatedAt: $updatedAt)';
}
