import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:librelab_api_client/src/auth_session.dart';
import 'package:librelab_api_client/src/auth_session_manager.dart';
import 'package:librelab_api_client/src/endpoints/endpoints.dart';
import 'package:librelab_api_client/src/exceptions.dart';
import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:logging/logging.dart';

// TODO: Update to support /auth/browser routes (fix old assumptions)

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

  Uri _buildUrl(
    HttpEndpoint endpoint, {
    required Map<String, Iterable<String>>? queryParameters,
    required Uri? overrideBaseUrl,
  }) {
    final baseUrl =
        overrideBaseUrl ??
        _baseUrl ??
        (throw StateError('The server base URL was not provided'));

    return baseUrl.replace(
      path: endpoint.path,
      queryParameters: queryParameters,
    );
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
      _buildUrl(
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

  late final _sessionManager = AuthSessionManager(
    this,
    logger: _logger,
    onAuthSessionRefreshed: _onAuthSessionRefreshed,
  );

  void setAuthSession(AuthSession? session) {
    _sessionManager.setAuthSession(session);
  }

  /// This is either the original request response (no refresh was attempted)
  /// or the retried request response (after a token refresh).
  ///
  /// Throws [AuthApiException] if the session has expired or if the refresh request failed.
  /// For more details, refer to the subclasses of [AuthApiException].
  Future<LibreLabApiResult<S>> requestAuthenticated<S>(
    HttpEndpoint endpoint, {
    Map<String, Iterable<String>>? queryParameters,
    Map<String, String>? headers,
    RequestBody? body,
    required JsonResponseDeserializer<S> deserializeSuccess,
  }) => _sessionManager.requestAuthenticated(
    endpoint,
    queryParameters: queryParameters,
    headers: headers,
    body: body,
    deserializeSuccess: deserializeSuccess,
    overrideAuthSession: null, // Do not override
    enableAutoTokenRefresh: true,
  );
}

typedef LibreLabApiResult<T> = HttpStatusResult<T, ServerErrorResponse>;
