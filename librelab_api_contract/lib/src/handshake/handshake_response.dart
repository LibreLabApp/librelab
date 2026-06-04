import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'handshake_response.g.dart';

enum ApiContractHandshakeStatus {
  /// Client and server API contract versions are identical.
  fullyCompatible,

  /// Server supports the client's API contract version within the supported range.
  /// Update is not required.
  compatible,

  /// Client API contract version is below the server's minimum supported version.
  /// The client is considered outdated.
  updateClient,

  /// Server API contract version is below the client's expected version.
  /// The server is considered outdated.
  updateServer,
}

@immutable
@JsonSerializable()
class HandshakeResponse {
  const HandshakeResponse({
    required this.serverBuildNumber,
    required this.serverVersion,
    required this.status,
  });

  factory HandshakeResponse.fromJson(JsonMap json) =>
      _$HandshakeResponseFromJson(json);

  JsonMap toJson() => _$HandshakeResponseToJson(this);

  final int serverBuildNumber;
  final String serverVersion;

  @JsonKey(
    // Adding a new enum not considered a breaking change.
    unknownEnumValue: ApiContractHandshakeStatus.updateClient,
  )
  final ApiContractHandshakeStatus status;
}
