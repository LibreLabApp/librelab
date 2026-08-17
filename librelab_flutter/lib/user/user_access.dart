import 'package:librelab_flutter/user/models/role.dart';
import 'package:librelab_flutter/user/models/user.dart';

/// Provides client-side access checks for a user.
///
/// Used to determine whether protected or important actions should be
/// available in the UI. The server remains responsible for enforcing access.
class UserAccess({
  required final List<Permission> permissions,
  required final bool isSuperUser,
}) {
  new fromUser(User user)
    : this(
        isSuperUser: user.isSuperUser,
        permissions: user.role?.permissions ?? [],
      );

  bool can(Permission permission) {
    return isSuperUser || permissions.contains(permission);
  }
}
