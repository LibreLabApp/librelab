import 'package:librelab_server/user/user.dart';
import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

abstract interface class UserRepository {
  Future<bool> hasUsers();

  Future<List<User>> findAll();
  Future<User?> findById(String id);
  Future<User?> findByEmail(String email);

  /// Returns token version for a user by id, or `null` if not found.
  ///
  /// This selects only [User.tokenVersion] instead of full user object.
  Future<int?> findTokenVersionById(String id);

  /// Returns minimal authenticated user for a user by id, or `null` if not found.
  ///
  /// This selects some column instead of full user object.
  ///
  /// See also: [AuthUser]
  Future<AuthUser?> findAuthUserById(String id);

  Future<bool> isEmailUsed(String email);

  /// Creates a new user.
  /// [UserCreate.email] must be unique (use [isEmailUsed] method)
  Future<User> create(UserCreate create);

  /// Returns whether the user was deleted.
  /// `false` if the user does not exist.
  Future<bool> delete(String id);

  /// Returns the updated user or `null` if the user
  /// does not exist.
  Future<User?> update(String id, UserPatch patch);
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
