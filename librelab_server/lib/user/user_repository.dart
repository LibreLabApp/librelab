import 'package:librelab_server/user/user.dart';

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
