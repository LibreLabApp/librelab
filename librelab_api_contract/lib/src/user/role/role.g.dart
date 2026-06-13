// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
  id: json['id'] as String,
  name: json['name'] as String,
  permissions: (json['permissions'] as List<dynamic>)
      .map(
        (e) => $enumDecode(
          _$PermissionEnumMap,
          e,
          unknownValue: Permission.unknown,
        ),
      )
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'permissions': instance.permissions
      .map((e) => _$PermissionEnumMap[e]!)
      .toList(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$PermissionEnumMap = {
  Permission.backupCreate: 'backupCreate',
  Permission.backupRestore: 'backupRestore',
  Permission.unknown: 'unknown',
};
