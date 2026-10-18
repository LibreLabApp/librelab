import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/compatibility/compatibility_checker.dart';
import 'package:librelab_server/generated/pubspec.g.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:shelf/shelf.dart';

/// Performs API contract compatibility check with this server instance.
///
/// Validates client/server compatibility only: no external version lookup
/// or update service is involved.
//
// NOTE: For this API, we strongly prefer non-breaking changes,
// even at the expense of a less-clean API.
class CompatibilityController {
  Future<Response> check(Request request) async {
    final body = await request.readJsonBody(
      fromJson: CompatibilityCheckRequest.fromJson,
    );
    final clientApiContractVersion = body.clientApiContractVersion;

    return _check(clientVersion: clientApiContractVersion)
        .toJson()
        .httpResponse(.ok);
  }

  CompatibilityCheckResponse _check({required int clientVersion}) => .new(
    status: CompatibilityChecker.resolve(clientVersion: clientVersion),
    serverBuildNumber: Pubspec.versionBuildNumber,
    serverVersion: Pubspec.version,
  );
}
