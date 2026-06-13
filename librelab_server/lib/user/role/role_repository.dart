import 'package:librelab_server/user/role/role.dart';
import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

abstract interface class RoleRepository {
  Future<List<Role>> findAll();
  Future<Role?> findById(String id);

  Future<Role> create({
    required String name,
    required List<Permission> permissions,
  });

  Future<bool> delete(String id);

  Future<Role?> update(String id, RolePatch patch);
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
