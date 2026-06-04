// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handshake_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HandshakeRequest _$HandshakeRequestFromJson(Map<String, dynamic> json) =>
    HandshakeRequest(
      clientApiContractVersion: (json['clientApiContractVersion'] as num)
          .toInt(),
    );

Map<String, dynamic> _$HandshakeRequestToJson(HandshakeRequest instance) =>
    <String, dynamic>{
      'clientApiContractVersion': instance.clientApiContractVersion,
    };
