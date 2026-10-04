import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';

class LabSettingsEndpoints(final LibreLabApiClient _client) {
  Future<LibreLabApiResult<LabSettings>> get() => _client.requestAuthenticated(
    ApiEndpointDefinitions.lab_settings$GET,
    deserializeSuccess: (response) => .fromJson(response.body),
  );

  Future<LibreLabApiResult<LabSettings>> update(
    UpdateLabSettingsRequest body,
  ) => _client.requestAuthenticated(
    ApiEndpointDefinitions.lab_settings$PATCH,
    body: .json(body.toJson()),
    deserializeSuccess: (response) => .fromJson(response.body),
  );
}
