import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart' as api;
import 'package:librelab_flutter/server_selection/compatibility/server_compatibility_check_response.dart';

class ServerCompatibilityRepository({
  required final LibreLabApiClient _client,
}) {
  Future<ServerCompatibilityCheckResponse> check() async {
    final response = await _client.request(
      ApiEndpointDefinitions.compatibility_check$POST,
      body: .json(
        const api.CompatibilityCheckRequest(
          clientApiContractVersion: api.ApiContractVersionConstants.version,
        ).toJson(),
      ),
      deserializeSuccess: (response) =>
          api.CompatibilityCheckResponse.fromJson(response.body),
    );
    // TODO: Complete (e.g., Error handling)
    return _map(response.success!.response.body);
  }

  ServerCompatibilityCheckResponse _map(api.CompatibilityCheckResponse dto) =>
      ServerCompatibilityCheckResponse(
        serverBuildNumber: dto.serverBuildNumber,
        serverVersion: dto.serverVersion,
        status: switch (dto.status) {
          .fullyCompatible => .fullyCompatible,
          .compatible => .compatible,
          .updateClient => .updateClient,
          .updateServer => .updateServer,
        },
      );
}
