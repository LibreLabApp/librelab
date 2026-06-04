import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'handshake_request.g.dart';

@immutable
@JsonSerializable()
class HandshakeRequest {
  const HandshakeRequest({required this.clientApiContractVersion});

  factory HandshakeRequest.fromJson(JsonMap json) =>
      _$HandshakeRequestFromJson(json);

  final int clientApiContractVersion;

  JsonMap toJson() => _$HandshakeRequestToJson(this);
}
