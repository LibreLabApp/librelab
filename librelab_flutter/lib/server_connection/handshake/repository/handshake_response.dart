import 'package:meta/meta.dart';

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
class HandshakeResponse {
  const HandshakeResponse({
    required this.serverBuildNumber,
    required this.serverVersion,
    required this.status,
  });

  final int serverBuildNumber;
  final String serverVersion;
  final ApiContractHandshakeStatus status;
}
