import 'package:librelab_api_contract/librelab_api_contract.dart';

abstract final class CompatibilityChecker {
  static ApiContractCompatibilityStatus resolve({required int clientVersion}) {
    const serverVersion = ApiContractVersionConstants.version;
    const minClientVersion = ApiContractVersionConstants.minSupportedVersion;

    if (clientVersion == serverVersion) {
      return .fullyCompatible;
    }

    if (clientVersion < minClientVersion) {
      return .updateClient;
    }

    if (clientVersion > serverVersion) {
      return .updateServer;
    }

    return .compatible;
  }
}
