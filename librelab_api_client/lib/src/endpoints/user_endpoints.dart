import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';

class UserEndpoints(final LibreLabApiClient _client) {
  Future<LibreLabApiResult<User>> me() => _client.requestAuthenticated(
    ApiEndpointDefinitions.users_me$GET,
    deserializeSuccess: (response) => .fromJson(response.body),
  );
}
