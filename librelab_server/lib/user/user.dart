import 'package:librelab_server/user/role/role.dart';
import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

@immutable
class const User({
  required final String id,
  required final String email,
  required final String passwordHash,
  required final int tokenVersion,
  required final String fullName,
  required final String? phoneNumber,
  required final bool isSuperUser,
  required final Role? role,
  required final DateTime createdAt,
  required final DateTime updatedAt,
}) {
  @override
  String toString() =>
      'User(id: $id, email: $email, passwordHash: **** (CENSORED), tokenVersion: $tokenVersion, fullName: $fullName, phoneNumber: $phoneNumber, isSuperUser: $isSuperUser, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
}

@immutable
sealed class const UserType();

final class const RegularUserType({required final int? roleId})
    extends UserType;

final class const SuperUserType() extends UserType;

@immutable
class const UserCreate({
  required final String email,
  required final String passwordHash,
  required final String fullName,
  required final String? phoneNumber,
  required final UserType type,
});

@immutable
class const UserPatch({
  final Field<String> fullName = const .absent(),
  final Field<String> email = const .absent(),
  final Field<String?> phoneNumber = const .absent(),
  final Field<int?> roleId = const .absent(),
  final Field<String> passwordHash = const .absent(),
  final Field<int> tokenVersion = const .absent(),
});

/// Minimal authenticated user used for request authorization.
///
/// Contains only identity and access-control data required during request
/// processing. Excludes sensitive fields (e.g., password hash) and full
/// profile/role metadata.
///
/// Permissions are pre-resolved permissions, not full role details.
///
/// See also: [User] (full user object)
@immutable
class const AuthUser({
  required final String id,
  required final int tokenVersion,
  required final bool isSuperUser,
  required final List<Permission>? permissions,
}) {
  @override
  String toString() =>
      'AuthUser(id: $id, tokenVersion: $tokenVersion, isSuperUser: $isSuperUser, permissions: $permissions)';
}
