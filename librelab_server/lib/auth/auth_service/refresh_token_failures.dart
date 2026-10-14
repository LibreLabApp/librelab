import 'package:librelab_shared/result.dart';

sealed class const RefreshTokenFailure(super.message) extends Failure;

/// The refresh token was not found.
/// The refresh token and/or the user may have been removed.
final class const TokenNotFoundFailure() extends RefreshTokenFailure {
  this : super('User refresh token was not found');
}

final class const TokenExpiredFailure() extends RefreshTokenFailure {
  this : super('Refresh token has expired');
}

/// Note: This is an indication of a bug or unexpected error, but it is
/// not thrown as a Dart Error to prevent disturbing the user.
///
/// The expected behavior:
/// if the user was deleted, then [TokenNotFoundFailure] should be returned,
/// not this failure.
final class const UserMissingForValidTokenFailure()
    extends RefreshTokenFailure {
  this
    : super(
        'Unexpected: The user refresh token was found and valid but the user was not found in the database',
      );
}
