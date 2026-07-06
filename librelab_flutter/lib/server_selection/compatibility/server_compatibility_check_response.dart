import 'package:meta/meta.dart';

enum ApiContractCompatibilityStatus {
  fullyCompatible,
  compatible,
  updateClient,
  updateServer;

  bool get isCompatible => this == compatible || this == fullyCompatible;
  bool get isIncompatible => this == updateClient || this == updateServer;
}

@immutable
class const ServerCompatibilityCheckResponse({
  required final int serverBuildNumber,
  required final String serverVersion,
  required final ApiContractCompatibilityStatus status,
});
