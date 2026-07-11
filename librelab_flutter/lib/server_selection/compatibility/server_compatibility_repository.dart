import 'package:json_safe/json_safe.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart' as api;
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:librelab_flutter/common/network/fallback_uri_request.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_compatibility_check_response.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

@immutable
sealed class const ServerTarget() {
  const factory useWebAppServer() = ServerTargetUseWebAppServer;

  const factory userProvided(String input) = ServerTargetUserProvided;

  const factory discoveredServer({
    required String hostnameAuthority,
    required String? ipAddressAuthority,
    required String? apiPath,
  }) = ServerTargetDiscovered;

  String get endpoint;
}

final class const ServerTargetUseWebAppServer() extends ServerTarget {
  Uri get _uri => Uri(path: ApiDeployment.rootPath);

  @override
  String get endpoint => _uri.toString();
}

final class const ServerTargetUserProvided(final String _input)
    extends ServerTarget {
  @override
  String get endpoint => _input;
}

final class const ServerTargetDiscovered({
  required final String _hostnameAuthority,
  required final String? _ipAddressAuthority,
  required final String? _apiPath,
}) extends ServerTarget {
  @override
  String get endpoint => _hostnameAuthority;
}

final class ServerCompatibilityCheckResult({
  required final ApiRequestResult<ServerCompatibilityCheckResponse> result,
  required final Uri uri,
});

class ServerCompatibilityRepository({
  required final LibreLabApiClient _client,
  required final ApiRequestHandler _handler,
  required final Logger _logger,
}) {
  Future<ServerCompatibilityCheckResult> check(
    ServerTarget serverTarget,
  ) async {
    late Uri capturedUri;

    final result = await _handler
        .execute<
          api.CompatibilityCheckResponse,
          ServerCompatibilityCheckResponse
        >(() async {
          switch (serverTarget) {
            case ServerTargetUseWebAppServer(:final _uri):
              capturedUri = _uri;
              return _client.endpoints.compatibility.check(_uri);

            case ServerTargetUserProvided(:final _input):
              final uri = Uri.parse(
                prependAuthorityDelimiterIfMissing(_input.trim()),
              );

              final result = await requestWithFallbackUris(
                uris: [() => uri.withHttps(), () => uri.withHttp()],
                request: (uri) async {
                  capturedUri = uri;
                  try {
                    // Important: await so that JsonParseException is thrown within this
                    // try block and can be caught below.
                    return await _client.endpoints.compatibility.check(uri);
                  } on JsonParseException catch (_) {
                    // The user may have provided the origin instead of the API root
                    // (example.org instead of example.org/api)
                    final isOriginRoot = uri.path.isEmpty || uri.path == '/';
                    if (!isOriginRoot) {
                      rethrow;
                    }

                    final updatedUri = uri.resolve(ApiDeployment.rootPath);
                    capturedUri = updatedUri;

                    _logger.finer(
                      'Compatibility check failed at origin root. \n'
                      'Retrying with API root: $updatedUri (previous: $uri)',
                    );

                    return _client.endpoints.compatibility.check(updatedUri);
                  }
                },
                logger: _logger,
              );

              return result.value;

            case ServerTargetDiscovered(
              _hostnameAuthority: final hostnameAuthority,
              _ipAddressAuthority: final ipAddressAuthority,
              _apiPath: final apiPath,
            ):

              // Important: each Uri is provided as a lazy factory closure instead of
              // being constructed eagerly. This avoids triggering FormatException during
              // list creation when some authority strings are invalid, which could prevent
              // request execution and leave capturedUri unassigned (leading to LateInitializationError).
              // Only the selected fallback URI is evaluated and constructed at runtime.
              final result = await requestWithFallbackUris(
                uris: [
                  () => Uri.https(hostnameAuthority),
                  () => Uri.http(hostnameAuthority),
                  if (ipAddressAuthority != null) ...[
                    // Workaround: The provided IP address could be an IPv6
                    // link-local-address, breaking the Uri construction.
                    // This is why each Uri is provided lazily instead of instantly.
                    // https://github.com/Skyost/Bonsoir/issues/145
                    () => Uri.https(ipAddressAuthority),
                    () => Uri.http(ipAddressAuthority),
                  ],
                ],
                request: (uri) {
                  final updatedUri = uri.replace(
                    path: apiPath ?? ApiDeployment.rootPath,
                  );
                  capturedUri = updatedUri;
                  return _client.endpoints.compatibility.check(updatedUri);
                },
                logger: _logger,
              );

              return result.value;
          }
        }, mapSuccess: (dto) => _map(dto));

    return ServerCompatibilityCheckResult(result: result, uri: capturedUri);
  }

  ServerCompatibilityCheckResponse _map(api.CompatibilityCheckResponse dto) =>
      .new(
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
