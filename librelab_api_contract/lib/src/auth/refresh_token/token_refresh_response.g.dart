// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRefreshResponse _$TokenRefreshResponseFromJson(
  Map<String, dynamic> json,
) => TokenRefreshResponse(
  accessToken: AuthToken.fromJson(json['accessToken'] as Map<String, dynamic>),
  refreshToken: AuthToken.fromJson(
    json['refreshToken'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$TokenRefreshResponseToJson(
  TokenRefreshResponse instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
};
