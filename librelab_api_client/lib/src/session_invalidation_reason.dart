/// Reason a session was invalidated during refresh flow.
///
/// Client-side + server-side outcomes for refresh token failure.
enum SessionInvalidationReason {
  /// Local expiry check marked refresh token as expired before request (expiresAt field).
  expiredByLocalCheck,

  /// Server responded that refresh token is expired.
  expiredByServer,

  /// Server did not find the refresh token (revoked/removed/user deleted)
  /// during token refresh.
  refreshTokenNotFound,

  /// The access token is not expired yet but the user was not found.
  userNotFound,
}
