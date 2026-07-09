import 'package:librelab_api_client/src/librelab_api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';

class CompatibilityEndpoints(final LibreLabApiClient _client) {
  Future<LibreLabApiResult<CompatibilityCheckResponse>> check(Uri url) =>
      _client.request(
        ApiEndpointDefinitions.compatibility_check$POST,
        body: .json(
          const CompatibilityCheckRequest(
            clientApiContractVersion: ApiContractVersionConstants.version,
          ).toJson(),
        ),
        deserializeSuccess: (response) => .fromJson(response.body),
        overrideBaseUrl: url,
      );
}
