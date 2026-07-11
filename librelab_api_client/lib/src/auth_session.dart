import 'package:librelab_api_client/src/is_token_expired.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:meta/meta.dart';

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
