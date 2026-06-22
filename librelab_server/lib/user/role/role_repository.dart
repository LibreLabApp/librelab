import 'package:librelab_server/user/role/role.dart';

abstract interface class RoleRepository {
  Future<List<Role>> findAll();
  Future<Role?> findById(String id);

  Future<Role> create(RoleCreate create);

  Future<bool> delete(String id);

  Future<Role?> update(String id, RolePatch patch);
}
