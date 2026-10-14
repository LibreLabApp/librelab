// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compatibility_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompatibilityCheckResponse _$CompatibilityCheckResponseFromJson(
  Map<String, dynamic> json,
) => CompatibilityCheckResponse(
  serverBuildNumber: (json['serverBuildNumber'] as num).toInt(),
  serverVersion: json['serverVersion'] as String,
  status: $enumDecode(
    _$ApiContractCompatibilityStatusEnumMap,
    json['status'],
    unknownValue: ApiContractCompatibilityStatus.updateClient,
  ),
);

Map<String, dynamic> _$CompatibilityCheckResponseToJson(
  CompatibilityCheckResponse instance,
) => <String, dynamic>{
  'serverBuildNumber': instance.serverBuildNumber,
  'serverVersion': instance.serverVersion,
  'status': _$ApiContractCompatibilityStatusEnumMap[instance.status]!,
};

const _$ApiContractCompatibilityStatusEnumMap = {
  ApiContractCompatibilityStatus.fullyCompatible: 'fullyCompatible',
  ApiContractCompatibilityStatus.compatible: 'compatible',
  ApiContractCompatibilityStatus.updateClient: 'updateClient',
  ApiContractCompatibilityStatus.updateServer: 'updateServer',
};
