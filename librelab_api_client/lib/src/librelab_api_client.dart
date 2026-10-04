import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:librelab_api_client/src/auth_session.dart';
import 'package:librelab_api_client/src/auth_session_manager.dart';
import 'package:librelab_api_client/src/endpoints/endpoints.dart';
import 'package:librelab_api_client/src/exceptions.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:logging/logging.dart';

export 'endpoints/auth_endpoints.dart';
export 'endpoints/compatibility_endpoints.dart';
export 'endpoints/file_storage_endpoints.dart';
export 'endpoints/lab_settings_endpoints.dart';

/// An API client for the LibreLab API.
///
/// Uses [HttpApiClient] for convenient handling of ordinary API requests with
/// structured JSON responses.
class LibreLabApiClient({
  required final HttpApiClient _apiClient,
  required final Logger? _logger,
  required final OnAuthSessionRefreshed? _onAuthSessionRefreshed,
}) {
  Uri? _baseUrl;
  Uri? get baseUrl => _baseUrl;
  Uri get baseUrlOrThrow =>
      baseUrl ??
      (throw StateError('API base URL has not been been configured.'));

  void setBaseUrl(Uri? baseUrl) {
    _baseUrl = baseUrl;
  }

  late final Endpoints endpoints = Endpoints(this);

  /// Returns the full request URL for the given [endpoint].
  Uri endpointUrl(
    EndpointDefinition endpoint, {
    Map<String, Iterable<String>>? queryParameters,
    Uri? overrideBaseUrl,
  }) => _buildRequestUrl(
    endpoint,
    queryParameters: queryParameters,
    overrideBaseUrl: overrideBaseUrl,
  );

  Uri _buildRequestUrl(
    EndpointDefinition endpoint, {
    required Map<String, Iterable<String>>? queryParameters,
    required Uri? overrideBaseUrl,
  }) {
    final baseUrl =
        overrideBaseUrl ??
        _baseUrl ??
        (throw StateError('The server base URL was not provided'));

    final normalizedBaseUrl = baseUrl.path.endsWith('/')
        ? baseUrl
        : baseUrl.replace(path: '${baseUrl.path}/');

    if (endpoint.path.startsWith('/')) {
      throw ArgumentError.value(
        endpoint.path,
        'endpointPath',
        'must not start with "/"',
      );
    }

    return normalizedBaseUrl
        .resolve(endpoint.path)
        .replace(queryParameters: queryParameters);
  }

  Future<LibreLabApiResult<S>> request<S>(
    HttpEndpoint endpoint, {
    Map<String, Iterable<String>>? queryParameters,
    Map<String, String>? headers,
    RequestBody? body,
    required JsonResponseDeserializer<S> deserializeSuccess,
    Uri? overrideBaseUrl,
  }) async {
    return _apiClient.requestJson(
      _buildRequestUrl(
        endpoint,
        queryParameters: queryParameters,
        overrideBaseUrl: overrideBaseUrl,
      ),
      method: endpoint.method,
      body: body,
      deserializeSuccess: deserializeSuccess,
      deserializeError: (response) =>
          ServerErrorResponse.fromJson(response.body),
      headers: headers,
    );
  }

  Future<LibreLabApiResult<Stream<List<int>>>> requestStreamed(
    HttpEndpoint endpoint, {
    Map<String, Iterable<String>>? queryParameters,
    Map<String, String>? headers,
    Uri? overrideBaseUrl,
  }) async {
    return _apiClient.requestStreamed(
      _buildRequestUrl(
        endpoint,
        queryParameters: queryParameters,
        overrideBaseUrl: overrideBaseUrl,
      ),
      method: endpoint.method,
      deserializeError: (response) =>
          ServerErrorResponse.fromJson(response.body),
      headers: headers,
    );
  }

  late final _sessionManager = AuthSessionManager(
    authEndpoints: endpoints.auth,
    logger: _logger,
    onAuthSessionRefreshed: _onAuthSessionRefreshed,
  );

  AuthSession? get authSession => _sessionManager.authSession;

  void setAuthSession(AuthSession? session) {
    _sessionManager.setAuthSession(session);
  }

  /// Makes an authenticated API request, automatically refreshing the access
  /// token and retrying the request when required.
  ///
  /// Returns either the original request response if no refresh was attempted,
  /// or the retried request response after a token refresh.
  ///
  /// Throws [AuthApiException] if the session has expired or if the refresh
  /// request failed. For more details, refer to the subclasses of
  /// [AuthApiException].
  Future<LibreLabApiResult<S>> requestAuthenticated<S>(
    HttpEndpoint endpoint, {
    Map<String, Iterable<String>>? queryParameters,
    Map<String, String>? headers,
    RequestBody? body,
    required JsonResponseDeserializer<S> deserializeSuccess,
  }) => _sessionManager.requestAuthenticated(
    endpoint,
    request: (context) => request(
      endpoint,
      body: body,
      queryParameters: queryParameters,
      deserializeSuccess: deserializeSuccess,
      headers: context.headers,
    ),
    headers: headers,
    overrideAuthSession: null, // Do not override
    enableAutoTokenRefresh: true,
  );

  /// Makes an authenticated API request and streams successful response bodies,
  /// automatically refreshing the access token and retrying the request when
  /// required.
  ///
  /// Returns either the original request response if no refresh was attempted,
  /// or the retried request response after a token refresh.
  ///
  /// Throws [AuthApiException] if the session has expired or if the refresh
  /// request failed. For more details, refer to the subclasses of
  /// [AuthApiException].
  Future<LibreLabApiResult<Stream<List<int>>>> requestAuthenticatedStreamed(
    HttpEndpoint endpoint, {
    Map<String, Iterable<String>>? queryParameters,
    Map<String, String>? headers,
  }) => _sessionManager.requestAuthenticated(
    endpoint,
    request: (context) => requestStreamed(
      endpoint,
      queryParameters: queryParameters,
      headers: context.headers,
    ),
    headers: headers,
    overrideAuthSession: null, // Do not override
    enableAutoTokenRefresh: true,
  );
}

/// The result of a LibreLab API request.
///
/// [T] is the type of the successful response body. If the request fails with
/// an API error, the result contains a [ServerErrorResponse] instead.
typedef LibreLabApiResult<T> = HttpStatusResult<T, ServerErrorResponse>;
