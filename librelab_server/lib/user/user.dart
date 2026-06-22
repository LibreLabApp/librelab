import 'package:librelab_server/user/role/role.dart';
import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

@immutable
class User {
  const User({
    required this.id,
    required this.email,
    required this.passwordHash,
    required this.tokenVersion,
    required this.fullName,
    required this.phoneNumber,
    required this.isSuperUser,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String email;
  final String passwordHash;
  final int tokenVersion;
  final String fullName;
  final String? phoneNumber;
  final bool isSuperUser;
  final Role? role;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  String toString() =>
      'User(id: $id, email: $email, passwordHash: **** (CENSORED), tokenVersion: $tokenVersion, fullName: $fullName, phoneNumber: $phoneNumber, isSuperUser: $isSuperUser, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
}

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
class AuthUser {
  AuthUser({
    required this.id,
    required this.tokenVersion,
    required this.isSuperUser,
    required List<Permission> permissions,
  }) : permissions = List.unmodifiable(permissions);

  final String id;
  final int tokenVersion;
  final bool isSuperUser;
  final List<Permission>? permissions;

  @override
  String toString() =>
      'AuthUser(id: $id, tokenVersion: $tokenVersion, isSuperUser: $isSuperUser, permissions: $permissions)';
}

@immutable
sealed class UserType {
  const UserType();
}

final class RegularUserType extends UserType {
  const RegularUserType({required this.roleId});

  final int? roleId;
}

final class SuperUserType extends UserType {
  const SuperUserType();
}

@immutable
class UserCreate {
  const UserCreate({
    required this.email,
    required this.passwordHash,
    required this.fullName,
    required this.phoneNumber,
    required this.type,
  });

  final String email;
  final String passwordHash;
  final String fullName;
  final String? phoneNumber;
  final UserType type;
}

@immutable
class UserPatch {
  const UserPatch({
    this.fullName = const .absent(),
    this.email = const .absent(),
    this.phoneNumber = const .absent(),
    this.roleId = const .absent(),
    this.passwordHash = const .absent(),
    this.tokenVersion = const .absent(),
  });

  final Field<String> fullName;
  final Field<String> email;
  final Field<String?> phoneNumber;
  final Field<int?> roleId;
  final Field<String> passwordHash;
  final Field<int> tokenVersion;
}
