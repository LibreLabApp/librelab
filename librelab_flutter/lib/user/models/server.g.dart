// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Server _$ServerFromJson(Map<String, dynamic> json) => Server(
  id: (json['id'] as num).toInt(),
  apiBaseUri: Uri.parse(json['apiBaseUri'] as String),
);

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
  'id': instance.id,
  'apiBaseUri': instance.apiBaseUri.toString(),
};
