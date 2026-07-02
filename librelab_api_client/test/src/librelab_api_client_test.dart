import 'package:api_client/api_client.dart';
// ignore: experimental_member_use
import 'package:api_client/test.dart';
import 'package:clock/clock.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:test/scaffolding.dart';

void main() {
  // ignore: experimental_member_use
  late HttpApiClientFake httpApiClient;
  late LibreLabApiClient client;

  setUp(() {
    // ignore: experimental_member_use
    httpApiClient = HttpApiClientFake();
    client = .new(apiClient: httpApiClient);

    client.setBaseUrl(Uri.http('stub.org'));
    client.setAuthSession(
      .new(
        userId: 'stub',
        accessToken: AuthToken(token: 'stub', expiresAt: DateTime(2000)),
        refreshToken: .new(token: 'stub', expiresAt: DateTime(2000)),
      ),
    );
  });

  // TODO: Implement unit tests for requestAuthenticated
}

extension on LibreLabApiClient {
  /// Sames as [LibreLabApiClient.requestAuthenticated] but forces a fixed [DateTime]
  /// via [fixedDateTime].
  // ignore: unused_element
  Future<HttpStatusResult<S, ServerErrorResponse>> requestAuthenticatedTest<S>(
    HttpEndpoint endpoint, {
    Map<String, Iterable<String>>? queryParameters,
    Map<String, String>? headers,
    RequestBody? body,
    required JsonResponseDeserializer<S> deserializeSuccess,
    DateTime? fixedDateTime,
  }) async {
    return withClock(Clock.fixed(fixedDateTime ?? DateTime(2025)), () {
      return requestAuthenticated(
        endpoint,
        queryParameters: queryParameters,
        headers: headers,
        body: body,
        deserializeSuccess: deserializeSuccess,
      );
    });
  }
}
