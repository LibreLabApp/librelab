import 'package:librelab_shared/result.dart';

sealed class RefreshTokenFailure extends Failure {
  const RefreshTokenFailure(super.message);
}

/// The refresh token was not found.
/// The refresh token and/or the user may have been removed.
final class TokenNotFoundFailure extends RefreshTokenFailure {
  const TokenNotFoundFailure() : super('User refresh token was not found');
}

final class TokenExpiredFailure extends RefreshTokenFailure {
  const TokenExpiredFailure() : super('Refresh token has expired');
}

/// Note: This is an indication of a bug or unexpected error, but it is
/// not thrown as a Dart Error to prevent disturbing the user.
///
/// The expected behavior:
/// if the user was deleted, then [TokenNotFoundFailure] should be returned,
/// not this failure.
final class UserMissingForValidTokenFailure extends RefreshTokenFailure {
  const UserMissingForValidTokenFailure()
    : super(
        'Unexpected: The user refresh token was found and valid but the user was not found in the database',
      );
}
