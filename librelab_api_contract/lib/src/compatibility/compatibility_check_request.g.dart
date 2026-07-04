// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compatibility_check_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompatibilityCheckRequest _$CompatibilityCheckRequestFromJson(
  Map<String, dynamic> json,
) => CompatibilityCheckRequest(
  clientApiContractVersion: (json['clientApiContractVersion'] as num).toInt(),
);

Map<String, dynamic> _$CompatibilityCheckRequestToJson(
  CompatibilityCheckRequest instance,
) => <String, dynamic>{
  'clientApiContractVersion': instance.clientApiContractVersion,
};
