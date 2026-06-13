import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/generated/pubspec.g.dart';
import 'package:librelab_server/utils/json_http_extensions.dart';
import 'package:librelab_server/utils/route_module.dart';
import 'package:librelab_server/utils/router_ext.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Performs API contract handshake with this server instance.
///
/// Validates client/server compatibility only: no external version lookup
/// or update service is involved.
//
// NOTE: For this API specifically, we strongly prefer non-breaking changes,
// even at the expense of a less-clean API.
class HandshakeRoutes implements RouteModule {
  @override
  Router get router =>
      Router()..register(ApiEndpointDefinitions.handshake$POST, _handler);

  Future<Response> _handler(Request request) async {
    final body = await request.readJsonBody(
      fromJson: HandshakeRequest.fromJson,
    );
    final clientApiContractVersion = body.clientApiContractVersion;

    return _check(version: clientApiContractVersion).toJson().httpResponse(.ok);
  }

  HandshakeResponse _check({required int version}) => HandshakeResponse(
    status: _resolve(client: version),
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
