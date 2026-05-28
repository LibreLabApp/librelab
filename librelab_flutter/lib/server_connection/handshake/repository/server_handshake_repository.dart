import 'package:librelab_client/librelab_client.dart' as g;
import 'package:librelab_flutter/server_connection/handshake/repository/handshake_response.dart';
import 'package:librelab_shared/librelab_shared.dart';

class ServerHandshakeRepository {
  ServerHandshakeRepository({required this.clientFactory});

  final g.Client Function(String serverBaseUrl) clientFactory;

  Future<HandshakeResponse> check(String serverBaseUrl) async {
    final client = clientFactory(serverBaseUrl);

    // TODO: Complete (e.g., Error handling)
    try {
      final response = await client.handshake.check(
        clientApiContractVersion: ApiContractVersionConstants.version,
      );
      return _map(response);
    } finally {
      client.close();
    }
  }

  HandshakeResponse _map(g.HandshakeResponse dto) => HandshakeResponse(
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
