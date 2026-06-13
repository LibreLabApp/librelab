import 'package:librelab_server/user/user.dart';
import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

@immutable
sealed class UserType {
  const UserType();
}

final class RegularUserType extends UserType {
  const RegularUserType({required this.roleId});

  final String roleId;
}

final class SuperUserType extends UserType {
  const SuperUserType();
}

abstract interface class UserRepository {
  Future<List<User>> findAll();
  Future<User?> findById(String id);
  Future<User?> findByEmail(String email);

  /// Returns token version for a user by id, or `null` if not found.
  ///
  /// This selects only [User.tokenVersion] instead of full user object.
  Future<int?> findTokenVersionById(String id);

  Future<bool> isEmailUsed(String email);

  /// Creates a new user.
  /// [email] must be unique (use [isEmailUsed] method)
  Future<User> create({
    required String email,
    required String passwordHash,
    required String fullName,
    required String? phoneNumber,
    required UserType type,
  });

  /// Returns whether the user was deleted.
  /// `false` if the user does not exist.
  Future<bool> delete(String id);

  /// Returns the updated user or `null` if the user
  /// does not exist.
  Future<User?> update(String id, UserPatch patch);
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
  final Field<String?> roleId;
  final Field<String> passwordHash;
  final Field<int> tokenVersion;
}
