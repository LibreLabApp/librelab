import 'package:meta/meta.dart';

enum ApiContractHandshakeStatus {
  fullyCompatible,
  compatible,
  updateClient,
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
