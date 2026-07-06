import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart' as api;
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:librelab_flutter/common/network/fallback_uri_request.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_compatibility_check_response.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

@immutable
sealed class const ServerTarget() {
  const factory manual(Uri uri) = ServerTargetManual;
  const factory discoveredServer({
    required String hostnameAuthority,
    required String? ipAddressAuthority,
  }) = ServerTargetDiscovered;

  String get endpoint;
}

final class const ServerTargetManual(final Uri uri) extends ServerTarget {
  @override
  String get endpoint => uri.toString();
}

final class const ServerTargetDiscovered({
  required final String hostnameAuthority,
  required final String? ipAddressAuthority,
}) extends ServerTarget {
  @override
  String get endpoint => hostnameAuthority;
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
            case ServerTargetManual(:final uri):
              capturedUri = uri;
              return _client.endpoints.compatibility.check(uri);
            case ServerTargetDiscovered(
              :final hostnameAuthority,
              :final ipAddressAuthority,
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
                    () => Uri.https(ipAddressAuthority),
                    () => Uri.http(ipAddressAuthority),
                  ],
                ],
                request: (uri) {
                  capturedUri = uri;
                  return _client.endpoints.compatibility.check(uri);
                },
                logger: _logger,
              );
              capturedUri = result.uri;
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
