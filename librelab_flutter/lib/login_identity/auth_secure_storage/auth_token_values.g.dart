// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokenValues _$AuthTokenValuesFromJson(Map<String, dynamic> json) =>
    AuthTokenValues(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$AuthTokenValuesToJson(AuthTokenValues instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
