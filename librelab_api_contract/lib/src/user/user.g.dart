// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  email: json['email'] as String,
  tokenVersion: (json['tokenVersion'] as num).toInt(),
  fullName: json['fullName'] as String,
  phoneNumber: json['phoneNumber'] as String?,
  isSuperUser: json['isSuperUser'] as bool,
  role: json['role'] == null
      ? null
      : Role.fromJson(json['role'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'tokenVersion': instance.tokenVersion,
  'fullName': instance.fullName,
  'phoneNumber': instance.phoneNumber,
  'isSuperUser': instance.isSuperUser,
  'role': instance.role,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
