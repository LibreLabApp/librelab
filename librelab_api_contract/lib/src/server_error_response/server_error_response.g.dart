// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerErrorResponse _$ServerErrorResponseFromJson(Map<String, dynamic> json) =>
    ServerErrorResponse(
      message: json['message'] as String,
      code: json['code'] as String,
      details: json['details'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ServerErrorResponseToJson(
  ServerErrorResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'code': instance.code,
  'details': instance.details,
};
