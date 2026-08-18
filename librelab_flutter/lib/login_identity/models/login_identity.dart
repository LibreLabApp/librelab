import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/common/json_types.dart' show JsonMap;
import 'package:librelab_flutter/user/models/user.dart';
import 'package:meta/meta.dart';

part 'login_identity.g.dart';

/// A user identity and server the application can use for authentication and
/// connection.
///
/// Represents a user added to the application for local use, distinct from
/// users managed on the server.
@immutable
@JsonSerializable()
class const LoginIdentity({
  required final int id,
  required final int serverId,
  required final User user,

  /// - Always null on web (managed by browsers, HttpOnly cookies).
  /// - On non-web platforms:
  ///   - null when stored in the system secure storage
  ///   - null when not found in either secure storage or file storage
  ///   - null when persisted with [persistAuthSession] set to `false`
  ///   - otherwise, stores the user's authentication tokens locally.
  required final UserAuthTokens? authTokens,

  /// Whether the authentication session should be persisted locally.
  ///
  /// On non-browser platforms, `false` prevents [authTokens] from being
  /// persisted and requires authentication again after restarting the app.
  ///
  /// Not applicable on browsers, where session persistence is managed by the
  /// browser. Users can use private, guest mode or incognito browsing for a temporary
  /// session.
  required final bool persistAuthSession,
}) {
  factory fromJson(JsonMap json) => _$LoginIdentityFromJson(json);
  JsonMap toJson() => _$LoginIdentityToJson(this);

  LoginIdentity withAuthTokens(UserAuthTokens? authTokens) => .new(
    id: id,
    serverId: serverId,
    user: user,
    authTokens: authTokens,
    persistAuthSession: persistAuthSession,
  );
}

@immutable
@JsonSerializable()
class const UserAuthTokens({
  required final AuthToken accessToken,
  required final AuthToken refreshToken,
}) {
  factory fromJson(JsonMap json) => _$UserAuthTokensFromJson(json);
  JsonMap toJson() => _$UserAuthTokensToJson(this);

  static UserAuthTokens? fromAuthSession(AuthSession session) {
    return switch (session) {
      AuthSessionMemory(:final accessToken, :final refreshToken) => .new(
        accessToken: .new(
          value: accessToken.value,
          expiresAt: accessToken.expiresAt,
        ),
        refreshToken: .new(
          value: refreshToken.value,
          expiresAt: refreshToken.expiresAt,
        ),
      ),
      AuthSessionBrowserCookie() => null,
    };
  }

  AuthSession toAuthSession(String userId) => .memory(
    userId: userId,
    accessToken: .new(
      value: accessToken.value,
      expiresAt: accessToken.expiresAt,
    ),
    refreshToken: .new(
      value: refreshToken.value,
      expiresAt: refreshToken.expiresAt,
    ),
  );
}

@immutable
@JsonSerializable()
class const AuthToken({
  required final String value,
  required final DateTime expiresAt,
}) {
  factory fromJson(JsonMap json) => _$AuthTokenFromJson(json);
  JsonMap toJson() => _$AuthTokenToJson(this);
}
