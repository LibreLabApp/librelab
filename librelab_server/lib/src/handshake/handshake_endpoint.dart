import 'dart:async';

import 'package:librelab_server/generated/pubspec.g.dart';
import 'package:librelab_server/src/generated/protocol.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:serverpod/serverpod.dart';

/// Performs API contract handshake with this server instance.
///
/// Validates client/server compatibility only: no external version lookup
/// or update service is involved.
///
// NOTE: We strongly prefer non-breaking changes, even at the expense of a
// less-clean API. https://docs.serverpod.dev/concepts/backward-compatibility
class HandshakeEndpoint extends Endpoint {
  Future<HandshakeResponse> check(
    Session session, {
    required int clientApiContractVersion,
  }) async => HandshakeResponse(
    status: _resolve(client: clientApiContractVersion),
    serverBuildNumber: Pubspec.versionBuildNumber,
    serverVersion: Pubspec.version,
  );

  ApiContractHandshakeStatus _resolve({required int client}) {
    const server = ApiContractVersionConstants.version;
    const minClient = ApiContractVersionConstants.minSupportedVersion;

    if (client == server) {
      return .fullyCompatible;
    }

    if (client < minClient) {
      return .updateClient;
    }

    if (client > server) {
      return .updateServer;
    }

    return .compatible;
  }
}
