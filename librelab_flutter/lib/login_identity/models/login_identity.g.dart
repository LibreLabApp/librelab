// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginIdentity _$LoginIdentityFromJson(Map<String, dynamic> json) =>
    LoginIdentity(
      id: (json['id'] as num).toInt(),
      serverId: (json['serverId'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      authTokens: json['authTokens'] == null
          ? null
          : AuthTokens.fromJson(json['authTokens'] as Map<String, dynamic>),
      persistAuthSession: json['persistAuthSession'] as bool,
      reauthRequired: json['reauthRequired'] as bool,
    );

Map<String, dynamic> _$LoginIdentityToJson(LoginIdentity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serverId': instance.serverId,
      'user': instance.user,
      'authTokens': instance.authTokens,
      'persistAuthSession': instance.persistAuthSession,
      'reauthRequired': instance.reauthRequired,
    };

AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => AuthTokens(
  accessToken: AuthToken.fromJson(json['accessToken'] as Map<String, dynamic>),
  refreshToken: AuthToken.fromJson(
    json['refreshToken'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AuthTokensToJson(AuthTokens instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) => AuthToken(
  value: json['value'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
);

Map<String, dynamic> _$AuthTokenToJson(AuthToken instance) => <String, dynamic>{
  'value': instance.value,
  'expiresAt': instance.expiresAt.toIso8601String(),
};
