import 'package:meta/meta.dart';

enum ApiContractCompatibilityStatus {
  fullyCompatible,
  compatible,
  updateClient,
  updateServer,
}

@immutable
class const ServerCompatibilityCheckResponse({
  required final int serverBuildNumber,
  required final String serverVersion,
  required final ApiContractCompatibilityStatus status,
});
