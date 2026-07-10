abstract final class AuthErrorCodes {
  static const String invalidLoginCredentials = 'INVALID_LOGIN_CREDENTIALS';
  static const String loginDisabled = 'LOGIN_DISABLED';

  static const String accessTokenExpired = 'ACCESS_TOKEN_EXPIRED';
  static const String unauthenticated = 'UNAUTHENTICATED';
  static const String reAuthenticationRequired = 'REAUTHENTICATION_REQUIRED';

  static const String insufficientPermissions = 'INSUFFICIENT_PERMISSIONS';
}

abstract final class AuthErrorDetailsKeys {
  /// Used with code is [AuthErrorCodes.reAuthenticationRequired]
  static const String reason = 'reason';
}
