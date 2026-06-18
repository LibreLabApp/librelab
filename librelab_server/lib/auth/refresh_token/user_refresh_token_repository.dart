import 'package:librelab_server/auth/refresh_token/user_refresh_token.dart';
import 'package:meta/meta.dart';

abstract interface class UserRefreshTokenRepository {
  /// [UserRefreshTokenClientMetadata.ipAddress] must be valid.
  Future<UserRefreshToken> create(UserRefreshTokenCreate create);

  /// Returns the list of user refresh tokens by user ID.
  Future<List<UserRefreshToken>> findRefreshTokensByUserId(String userId);

  /// Finds a user refresh token by the token hash.
  Future<UserRefreshToken?> findByTokenHash(String tokenHash);

  /// Deletes a user refresh token by the token's ID.
  ///
  /// Returns whether the row was deleted.
  /// `false` if the row does not exist.
  Future<bool> deleteById(int id);

  /// Deletes a user refresh token by the token hash.
  ///
  /// Returns whether the row was deleted.
  /// `false` if the row does not exist.
  Future<bool> deleteByTokenHash(String tokenHash);

  /// Deletes all refresh tokens for the specified user.
  ///
  /// Returns the number of tokens deleted.
  Future<int> deleteRefreshTokensByUserId(String userId);

  /// Deletes all expired refresh tokens.
  ///
  /// Returns the number of tokens deleted.
  Future<int> deleteExpiredRefreshTokens();
}

@immutable
class UserRefreshTokenCreate {
  const UserRefreshTokenCreate({
    required this.userId,
    required this.tokenHash,
    required this.clientMetadata,
    required this.expiresAt,
  });

  final String userId;
  final String tokenHash;
  final UserRefreshTokenClientMetadata clientMetadata;
  final DateTime expiresAt;
}
