import 'package:meta/meta.dart';

/// Reason the current auth session became unusable.
@immutable
sealed class const SessionInvalidationReason() {
  const factory expiredByLocalCheck() = ExpiredByLocalCheck;
  const factory serverDetermined(
    String? reason,
    String message, {
    required bool isDuringTokenRefresh,
  }) = ServerDetermined;
}

/// The client determined that the refresh token has already expired
/// based on its stored expiration time (`expiresAt`).
final class const ExpiredByLocalCheck() extends SessionInvalidationReason {
  @override
  String toString() => 'ExpiredByLocalCheck()';
}

/// The server determined that the current session is no longer valid and
/// reauthentication is required.
///
/// Possible reasons:
///
/// - The refresh token has expired.
///
/// - Browser only: The refresh token cookie was not provided.
///   The browser may have removed the cookie after it expired.
///
/// - The refresh token was provided but not found in the server database
///   during token refresh (e.g. it was revoked, removed, or the user was deleted).
///
/// - The user associated with the access token was not found.
///
final class const ServerDetermined(
  /// Typically non-null, but not guaranteed.
  /// It is kept nullable for backward compatibility.
  final String? reason,
  final String message, {

  /// Whether this was received while performing a token refresh request.
  required final bool isDuringTokenRefresh,
}) extends SessionInvalidationReason {
  @override
  String toString() =>
      'ServerDetermined(reason: $reason, isDuringTokenRefresh: $isDuringTokenRefresh, message: $message)';
}
