import 'package:librelab_server/user/role/role.dart';
import 'package:librelab_server/user/user.dart';

/// Provides access checks for a user.
///
/// Used to determine whether a user has permission to perform a given action.
class UserAccess({
  required final List<Permission> userPermissions,
  required final bool isSuperUser,
}) {
  new fromUser(User user)
    : this(
        isSuperUser: user.isSuperUser,
        userPermissions: user.role?.permissions ?? [],
      );

  new fromAuthUser(AuthUser user)
    : this(
        isSuperUser: user.isSuperUser,
        userPermissions: user.permissions ?? [],
      );

  bool can(Permission permission) {
    return isSuperUser || userPermissions.contains(permission);
  }
}
