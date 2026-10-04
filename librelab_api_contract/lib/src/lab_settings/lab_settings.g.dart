// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabSettings _$LabSettingsFromJson(Map<String, dynamic> json) => LabSettings(
  labName: json['labName'] as String?,
  loginDisabled: json['loginDisabled'] as bool,
  labImageId: json['labImageId'] as String?,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$LabSettingsToJson(LabSettings instance) =>
    <String, dynamic>{
      'labName': instance.labName,
      'loginDisabled': instance.loginDisabled,
      'labImageId': instance.labImageId,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
