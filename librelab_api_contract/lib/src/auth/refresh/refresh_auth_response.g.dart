// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshAuthResponse _$RefreshAuthResponseFromJson(Map<String, dynamic> json) =>
    RefreshAuthResponse(
      accessToken: AuthToken.fromJson(
        json['accessToken'] as Map<String, dynamic>,
      ),
      refreshToken: AuthToken.fromJson(
        json['refreshToken'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$RefreshAuthResponseToJson(
  RefreshAuthResponse instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
};
