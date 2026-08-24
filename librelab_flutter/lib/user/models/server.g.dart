// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Server _$ServerFromJson(Map<String, dynamic> json) => Server(
  id: (json['id'] as num).toInt(),
  apiBaseUrl: Uri.parse(json['apiBaseUrl'] as String),
  name: json['name'] as String,
);

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
  'id': instance.id,
  'apiBaseUrl': instance.apiBaseUrl.toString(),
  'name': instance.name,
};
