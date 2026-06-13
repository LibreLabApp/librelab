import 'package:api_client/api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart' as api;
import 'package:librelab_flutter/server_connection/handshake/repository/handshake_response.dart';

class ServerHandshakeRepository {
  ServerHandshakeRepository({required this.apiClient});

  final ApiClient apiClient;

  Future<HandshakeResponse> check(String serverBaseUrl) async {
    // TODO: Complete (e.g., Error handling, server api client specific utility to not repeat HTTP method)

    const endpoint = ApiEndpointDefinitions.handshake$POST;

    final base = Uri.parse(serverBaseUrl);
    final fullUri = base.replace(path: endpoint.path);

    final response = await apiClient.requestJson(
      fullUri,
      method: endpoint.method,
      body: .json(
        const api.HandshakeRequest(
          clientApiContractVersion: api.ApiContractVersionConstants.version,
        ).toJson(),
      ),
      deserializeSuccess: (response) =>
          api.HandshakeResponse.fromJson(response.body),
      deserializeFailure: (response) =>
          api.ServerErrorResponse.fromJson(response.body),
    );
    return _map(response.valueOrThrow.body);
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
