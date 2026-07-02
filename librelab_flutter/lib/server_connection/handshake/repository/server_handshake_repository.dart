import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart' as api;
import 'package:librelab_flutter/server_connection/handshake/repository/handshake_response.dart';

class ServerHandshakeRepository({required final LibreLabApiClient _client}) {
  Future<HandshakeResponse> check() async {
    final response = await _client.request(
      ApiEndpointDefinitions.handshake$POST,
      body: .json(
        const api.HandshakeRequest(
          clientApiContractVersion: api.ApiContractVersionConstants.version,
        ).toJson(),
      ),
      deserializeSuccess: (response) =>
          api.HandshakeResponse.fromJson(response.body),
    );
    // TODO: Complete (e.g., Error handling)
    return _map(response.success!.response.body);
  }

  HandshakeResponse _map(api.HandshakeResponse dto) => HandshakeResponse(
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
