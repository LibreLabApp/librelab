// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_refresh_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRefreshRequest _$TokenRefreshRequestFromJson(Map<String, dynamic> json) =>
    TokenRefreshRequest(
      refreshToken: json['refreshToken'] as String,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$TokenRefreshRequestToJson(
  TokenRefreshRequest instance,
) => <String, dynamic>{
  'refreshToken': instance.refreshToken,
  'deviceId': instance.deviceId,
};
