import 'package:meta/meta.dart';

enum ApiContractHandshakeStatus {
  fullyCompatible,
  compatible,
  updateClient,
  updateServer,
}

@immutable
class const HandshakeResponse({
  required final int serverBuildNumber,
  required final String serverVersion,
  required final ApiContractHandshakeStatus status,
});
