// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabSettingsResponse _$LabSettingsResponseFromJson(Map<String, dynamic> json) =>
    LabSettingsResponse(
      labName: json['labName'] as String?,
      loginDisabled: json['loginDisabled'] as bool,
    );

Map<String, dynamic> _$LabSettingsResponseToJson(
  LabSettingsResponse instance,
) => <String, dynamic>{
  'labName': instance.labName,
  'loginDisabled': instance.loginDisabled,
};
