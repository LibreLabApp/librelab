import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/auth/login_identity/login_identity_repository.dart';
import 'package:librelab_flutter/auth/login_identity/models/login_identities.dart';
import 'package:librelab_flutter/auth/login_identity/models/login_identity.dart';
import 'package:librelab_flutter/user/models/server.dart';
import 'package:librelab_flutter/user/models/user.dart';

/// Manages login identities and the active authentication session.
/// Does not perform initiate authentication.
class LoginIdentityService({
  required final LibreLabApiClient _client,
  required final LoginIdentityRepository _loginIdentityRepository,
}) {
  /// Completes a login by creating or updating the login identity, selecting it,
  /// persisting it, and configuring the API client's active authentication session.
  /// Does not initiate authentication. The authentication result must be provided.
  Future<void> completeLogin({
    required Uri serverBaseUrl,
    required String labName,
    required User user,
    required AuthSession authSession,
    required bool persistAuthSession,
  }) async {
    final loginIdentities = await _loginIdentityRepository.read();

    final existingServer = loginIdentities.servers
        .where((server) => server.apiBaseUri == serverBaseUrl)
        .firstOrNull;

    final server =
        existingServer ??
        Server(
          id: _nextId(loginIdentities.servers.map((server) => server.id)),
          apiBaseUri: serverBaseUrl,
          name: labName,
        );

    final existingLoginIdentity = loginIdentities.loginIdentities
        .where((loginIdentity) => loginIdentity.user.id == user.id)
        .firstOrNull;

    final loginIdentity = LoginIdentity(
      id:
          existingLoginIdentity?.id ??
          _nextId(
            loginIdentities.loginIdentities.map(
              (loginIdentity) => loginIdentity.id,
            ),
          ),
      serverId: server.id,
      user: user,
      // LoginIdentityRepository handles whether authentication tokens should be
      // persisted.
      authTokens: .fromAuthSession(authSession),
      persistAuthSession: persistAuthSession,
    );

    await _loginIdentityRepository.write(
      loginIdentities.copyWith(
        servers: [
          ...loginIdentities.servers,
          if (existingServer == null) server,
        ],
        loginIdentities: [
          ...loginIdentities.loginIdentities.where(
            (existing) => existing.id != loginIdentity.id,
          ),
          loginIdentity,
        ],
        selectedLoginIdentityId: loginIdentity.id,
      ),
    );

    _configureClient(serverBaseUrl, authSession);
  }

  /// Returns the currently selected login identity and its associated server.
  /// Returns `null` if no login identity is selected.
  /// Throws [StateError] if the selected login identity or its associated server
  /// does not resolve to exactly one entry.
  Future<(LoginIdentity, Server)?> currentLoginIdentity() async {
    final loginIdentities = await _loginIdentityRepository.read();

    final selectedLoginIdentityId = loginIdentities.selectedLoginIdentityId;
    if (selectedLoginIdentityId == null) {
      return null;
    }

    final loginIdentity = loginIdentities.loginIdentities.singleWhereOrNull(
      (loginIdentity) => loginIdentity.id == selectedLoginIdentityId,
    );

    if (loginIdentity == null) {
      throw StateError(
        'Selected login identity $selectedLoginIdentityId does not resolve to '
        'exactly one login identity.',
      );
    }

    final server = loginIdentities.servers.singleWhereOrNull(
      (server) => server.id == loginIdentity.serverId,
    );

    if (server == null) {
      throw StateError(
        'Server ${loginIdentity.serverId} referenced by login identity '
        '${loginIdentity.id} does not resolve to exactly one server.',
      );
    }

    return (loginIdentity, server);
  }

  /// Selects a login identity, persists the selection, and configures the API
  /// client with the selected server and authentication session.
  /// Throws [StateError] if [loginIdentityId] does not resolve to exactly one
  /// login identity, its associated server does not resolve to exactly one entry,
  /// or authentication tokens are not found on a non-browser platform.
  Future<void> selectLoginIdentity(int loginIdentityId) async {
    final loginIdentities = await _loginIdentityRepository.read();

    final loginIdentity = loginIdentities.loginIdentities.singleWhereOrNull(
      (loginIdentity) => loginIdentity.id == loginIdentityId,
    );

    if (loginIdentity == null) {
      throw StateError(
        'Login identity $loginIdentityId does not resolve to exactly one '
        'login identity.',
      );
    }

    final server = loginIdentities.servers.singleWhereOrNull(
      (server) => server.id == loginIdentity.serverId,
    );

    if (server == null) {
      throw StateError(
        'Server ${loginIdentity.serverId} referenced by login identity '
        '${loginIdentity.id} does not resolve to exactly one server.',
      );
    }

    await _loginIdentityRepository.write(
      loginIdentities.copyWith(selectedLoginIdentityId: loginIdentity.id),
    );

    _configureClientFromLoginIdentity(loginIdentity, server);
  }

  /// Returns all locally configured login identities and their associated servers.
  Future<LoginIdentities> read() async {
    return _loginIdentityRepository.read();
  }

  /// Restores the currently selected login identity and configures the API client
  /// with its server and authentication session.
  /// Returns `null` if no login identity is selected.
  ///
  /// Throws [StateError] if the selected login identity or its associated server
  /// does not resolve to exactly one entry, or authentication tokens are not found
  /// on a non-browser platform.
  Future<(LoginIdentity, Server)?> restoreCurrentLoginIdentity() async {
    final current = await currentLoginIdentity();
    if (current == null) {
      return null;
    }

    final (loginIdentity, server) = current;
    _configureClientFromLoginIdentity(loginIdentity, server);

    return current;
  }

  /// Returns the first positive integer not present in [ids].
  int _nextId(Iterable<int> ids) {
    var id = 1;
    final usedIds = ids.toSet();

    while (usedIds.contains(id)) {
      id++;
    }

    return id;
  }

  /// Configures the API client with the login identity's server and authentication session.
  /// Throws [StateError] if authentication tokens are not found on a non-browser platform.
  void _configureClientFromLoginIdentity(
    LoginIdentity loginIdentity,
    Server server,
  ) {
    final userId = loginIdentity.user.id;

    final AuthSession authSession = kIsWeb
        ? .browserCookie(userId: userId)
        : loginIdentity.authTokens?.toAuthSession(userId) ??
              (throw StateError(
                'Login identity ${loginIdentity.id} does not have persisted '
                'authentication tokens.',
              ));

    _configureClient(server.apiBaseUri, authSession);
  }

  /// Configures the API client with the login identity's server and authentication session.
  void _configureClient(Uri serverBaseUrl, AuthSession authSession) {
    _client.setBaseUrl(serverBaseUrl);
    _client.setAuthSession(authSession);
  }
}
