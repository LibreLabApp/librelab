// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_null_checks

part of 'handshake_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HandshakeResponse _$HandshakeResponseFromJson(Map<String, dynamic> json) =>
    HandshakeResponse(
      serverBuildNumber: (json['serverBuildNumber'] as num).toInt(),
      serverVersion: json['serverVersion'] as String,
      status: $enumDecode(
        _$ApiContractHandshakeStatusEnumMap,
        json['status'],
        unknownValue: ApiContractHandshakeStatus.updateClient,
      ),
    );

Map<String, dynamic> _$HandshakeResponseToJson(HandshakeResponse instance) =>
    <String, dynamic>{
      'serverBuildNumber': instance.serverBuildNumber,
      'serverVersion': instance.serverVersion,
      'status': _$ApiContractHandshakeStatusEnumMap[instance.status]!,
    };

const _$ApiContractHandshakeStatusEnumMap = {
  ApiContractHandshakeStatus.fullyCompatible: 'fullyCompatible',
  ApiContractHandshakeStatus.compatible: 'compatible',
  ApiContractHandshakeStatus.updateClient: 'updateClient',
  ApiContractHandshakeStatus.updateServer: 'updateServer',
};
