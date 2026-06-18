import 'package:librelab_server/user/role/role.dart';
import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

abstract interface class RoleRepository {
  Future<List<Role>> findAll();
  Future<Role?> findById(String id);

  Future<Role> create(RoleCreate create);

  Future<bool> delete(String id);

  Future<Role?> update(String id, RolePatch patch);
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
