import 'package:librelab_api_client/src/is_token_expired.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:meta/meta.dart';

/// Represents the client-side authentication session for a user.
///
/// A session either stores authentication tokens in memory or relies on the
/// browser to manage authentication through HttpOnly cookies.
@immutable
sealed class const AuthSession({required final String userId}) {
  const factory AuthSession.memory({
    required String userId,
    required AuthToken accessToken,
    required AuthToken refreshToken,
  }) = AuthSessionMemory;

  const factory AuthSession.browserCookie({required String userId}) =
      AuthSessionBrowserCookie;
}

/// An authentication session that stores its access and refresh tokens in
/// memory.
final class const AuthSessionMemory({
  required super.userId,
  required final AuthToken accessToken,
  required final AuthToken refreshToken,
}) extends AuthSession {
  AuthSessionMemory copyWith({
    required AuthToken accessToken,
    required AuthToken refreshToken,
  }) {
    return AuthSessionMemory(
      userId: userId,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

/// An authentication session managed by the browser through HttpOnly cookies.
///
/// This session type is used only on the web platform.
final class const AuthSessionBrowserCookie({required super.userId})
    extends AuthSession;

extension AuthSessionX on AuthSession {
  bool? isAccessTokenExpired() => switch (this) {
    AuthSessionMemory(:final accessToken) => isTokenExpired(
      accessToken.expiresAt,
    ),
    AuthSessionBrowserCookie() => null,
  };

  bool? isRefreshTokenExpired() => switch (this) {
    AuthSessionMemory(:final refreshToken) => isTokenExpired(
      refreshToken.expiresAt,
    ),
    AuthSessionBrowserCookie() => null,
  };
}
