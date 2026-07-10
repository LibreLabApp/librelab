import 'package:meta/meta.dart';

/// Reason the current auth session became unusable.
@immutable
sealed class const SessionInvalidationReason() {
  const factory expiredByLocalCheck() = ExpiredByLocalCheck;
  const factory serverDetermined(String? reason, String message) =
      ServerDetermined;
}

/// The client determined that the refresh token has already expired
/// based on its stored expiration time (`expiresAt`).
final class const ExpiredByLocalCheck() extends SessionInvalidationReason {
  @override
  String toString() => '$ExpiredByLocalCheck()';
}

/// The server determined that the current session is no longer valid and
/// reauthentication is required.
///
/// - The refresh token has expired.
///
/// - Browser only: The refresh token cookie was not provided.
///   The browser may have removed the cookie after it expired.
///
/// - Browsers only: The client did not provide the refresh token cookie.
///   The cookie may have expired by the browser.
///
/// - The refresh token was provided but not found in the server database
///   during token refresh (e.g. it was revoked, removed, or the user was deleted).
///
/// - The user associated with the access token was not found.
///
/// [reason] is typically non-null, but not guaranteed.
/// It is kept nullable for backward compatibility.
final class const ServerDetermined(final String? reason, final String message)
    extends SessionInvalidationReason {
  @override
  String toString() => '$ServerDetermined(reason: $reason, message: $message)';
}
