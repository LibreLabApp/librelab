abstract final class AuthErrorCodes {
  static const String invalidLoginCredentials = 'INVALID_LOGIN_CREDENTIALS';
  static const String loginDisabled = 'LOGIN_DISABLED';

  static const String accessTokenExpired = 'ACCESS_TOKEN_EXPIRED';

  static const String refreshTokenExpired = 'REFRESH_TOKEN_EXPIRED';
  static const String refreshTokenNotFound = 'REFRESH_TOKEN_NOT_FOUND';

  /// Returns whether re-authentication is required
  static bool isInvalidRefreshToken(String code) {
    return [refreshTokenExpired, refreshTokenNotFound].contains(code);
  }

  static const String userNotFound = 'USER_NOT_FOUND';

  static const String insufficientPermissions = 'INSUFFICIENT_PERMISSIONS';
}
