import 'package:librelab_api_client/src/librelab_api_client.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';

class AuthEndpoints(final LibreLabApiClient _client) {
  final AuthBrowserEndpoints browser = AuthBrowserEndpoints(_client);

  Future<LibreLabApiResult<LoginResponse>> login(LoginRequest body) =>
      _client.request(
        ApiEndpointDefinitions.auth_login$POST,
        body: .json(body.toJson()),
        deserializeSuccess: (response) => .fromJson(response.body),
      );

  Future<LibreLabApiResult<LogoutResponse>> logout(LogoutRequest body) =>
      _client.request(
        ApiEndpointDefinitions.auth_logout$POST,
        body: .json(body.toJson()),
        deserializeSuccess: (response) => .fromJson(response.body),
      );

  Future<LibreLabApiResult<RefreshAuthResponse>> refresh(
    RefreshAuthRequest body,
  ) => _client.request(
    ApiEndpointDefinitions.auth_refresh$POST,
    body: .json(body.toJson()),
    deserializeSuccess: (response) => .fromJson(response.body),
  );
}

/// Depends on browser-specific capabilities (e.g., HttpOnly cookies).
/// Access and refresh tokens are managed by the browser.
class AuthBrowserEndpoints(final LibreLabApiClient _client) {
  Future<LibreLabApiResult<LoginBrowserResponse>> login(LoginRequest body) =>
      _client.request(
        ApiEndpointDefinitions.auth_browser_login$POST,
        body: .json(body.toJson()),
        deserializeSuccess: (response) => .fromJson(response.body),
      );

  Future<LibreLabApiResult<LogoutResponse>> logout() => _client.request(
    ApiEndpointDefinitions.auth_browser_logout$POST,
    deserializeSuccess: (response) => .fromJson(response.body),
  );

  Future<LibreLabApiResult<void>> refresh() => _client.request(
    ApiEndpointDefinitions.auth_browser_refresh$POST,
    deserializeSuccess: (_) {},
  );
}
