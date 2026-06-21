// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_lab_settings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLabSettingsRequest _$UpdateLabSettingsRequestFromJson(
  Map<String, dynamic> json,
) => UpdateLabSettingsRequest(
  labName: json['labName'] as String?,
  loginDisabled: json['loginDisabled'] as bool?,
);

Map<String, dynamic> _$UpdateLabSettingsRequestToJson(
  UpdateLabSettingsRequest instance,
) => <String, dynamic>{
  'labName': instance.labName,
  'loginDisabled': instance.loginDisabled,
};
