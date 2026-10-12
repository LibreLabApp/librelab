import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/login_identity/login_identity_repository/login_identity_repository.dart';
import 'package:librelab_flutter/login_identity/models/login_identities.dart';
import 'package:librelab_flutter/login_identity/models/login_identity.dart';
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
  ///
  /// Does not initiate authentication or make API requests. The authentication
  /// result must be provided.
  Future<CompleteLoginResult> completeLogin({
    required Uri serverBaseUrl,
    required String labName,
    required User user,
    required AuthSession authSession,
    required bool persistAuthSession,
  }) async {
    final existingLoginIdentities = await _loginIdentityRepository.read();

    final existingServer = existingLoginIdentities.servers
        .where((server) => server.apiBaseUrl == serverBaseUrl)
        .firstOrNull;

    final server =
        existingServer ??
        Server(
          id: _nextId(
            existingLoginIdentities.servers.map((server) => server.id),
          ),
          apiBaseUrl: serverBaseUrl,
          name: labName,
        );

    final existingLoginIdentity = existingLoginIdentities.list
        .where((loginIdentity) => loginIdentity.user.id == user.id)
        .firstOrNull;

    final loginIdentity = LoginIdentity(
      id:
          existingLoginIdentity?.id ??
          _nextId(
            existingLoginIdentities.list.map(
              (loginIdentity) => loginIdentity.id,
            ),
          ),
      serverId: server.id,
      user: user,
      // LoginIdentityRepository handles whether authentication tokens should be
      // persisted.
      authTokens: .fromAuthSession(authSession),
      persistAuthSession: persistAuthSession,
      reauthRequired: false,
    );

    final otherLoginIdentities = existingLoginIdentities.list.where(
      (existing) => existing.id != loginIdentity.id,
    );

    final updatedLoginIdentities = existingLoginIdentities.copyWith(
      servers: [
        ...existingLoginIdentities.servers,
        if (existingServer == null) server,
      ],
      list: [...otherLoginIdentities, loginIdentity],
      selectedLoginIdentityId: loginIdentity.id,
    );

    await _loginIdentityRepository.write(updatedLoginIdentities);

    _configureClient(serverBaseUrl, authSession);

    return .new(
      loginIdentities: updatedLoginIdentities,
      loginIdentity: loginIdentity,
      isNew: existingLoginIdentity == null,
    );
  }

  /// Returns the currently selected login identity and its associated server.
  ///
  /// Returns `null` if no login identity is selected.
  ///
  /// Throws [StateError] if the selected login identity or its associated server
  /// does not resolve to exactly one entry in [loginIdentities].
  (LoginIdentity, Server)? currentLoginIdentity(
    LoginIdentities loginIdentities,
  ) {
    final selectedLoginIdentityId = loginIdentities.selectedLoginIdentityId;

    if (selectedLoginIdentityId == null) {
      return null;
    }

    final loginIdentity = loginIdentities.list.singleWhereOrNull(
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
  ///
  /// Returns the updated [LoginIdentities].
  Future<LoginIdentities> selectLoginIdentity(int loginIdentityId) async {
    final existingLoginIdentities = await _loginIdentityRepository.read();

    final loginIdentity = existingLoginIdentities.list.singleWhereOrNull(
      (loginIdentity) => loginIdentity.id == loginIdentityId,
    );

    if (loginIdentity == null) {
      throw StateError(
        'Login identity $loginIdentityId does not resolve to exactly one '
        'login identity.',
      );
    }

    final server = existingLoginIdentities.servers.singleWhereOrNull(
      (server) => server.id == loginIdentity.serverId,
    );

    if (server == null) {
      throw StateError(
        'Server ${loginIdentity.serverId} referenced by login identity '
        '${loginIdentity.id} does not resolve to exactly one server.',
      );
    }

    final updatedLoginIdentities = existingLoginIdentities.copyWith(
      selectedLoginIdentityId: loginIdentity.id,
    );

    await _loginIdentityRepository.write(updatedLoginIdentities);

    _configureClientFromLoginIdentity(loginIdentity, server);

    return updatedLoginIdentities;
  }

  /// Removes the login identity with [loginIdentityId] and updates the selected
  /// login identity accordingly.
  ///
  /// If the removed login identity is selected, another login identity is
  /// selected when available; otherwise, no login identity is selected.
  ///
  /// Throws [StateError] if [loginIdentityId] does not resolve to exactly one
  /// login identity.
  ///
  /// Returns the updated [LoginIdentities].
  Future<LoginIdentities> removeLoginIdentity(int loginIdentityId) async {
    final existingLoginIdentities = await _loginIdentityRepository.read();

    final loginIdentity = existingLoginIdentities.list.singleWhereOrNull(
      (loginIdentity) => loginIdentity.id == loginIdentityId,
    );

    if (loginIdentity == null) {
      throw StateError(
        'Login identity $loginIdentityId does not resolve to exactly one '
        'login identity.',
      );
    }

    final remainingLoginIdentities = existingLoginIdentities.list
        .where((loginIdentity) => loginIdentity.id != loginIdentityId)
        .toList();

    final selectedLoginIdentityId =
        existingLoginIdentities.selectedLoginIdentityId == loginIdentityId
        ? remainingLoginIdentities.firstOrNull?.id
        : existingLoginIdentities.selectedLoginIdentityId;

    final updatedLoginIdentities = existingLoginIdentities.copyWith(
      list: remainingLoginIdentities,
      selectedLoginIdentityId: selectedLoginIdentityId,
    );

    await _loginIdentityRepository.write(updatedLoginIdentities);

    return updatedLoginIdentities;
  }

  /// Marks the login identity for [userId] as requiring reauthentication and
  /// removes its authentication tokens.
  ///
  /// Throws [StateError] if [userId] does not resolve to exactly one login
  /// identity.
  Future<LoginIdentities> markReauthenticationRequired(String userId) async {
    final existingLoginIdentities = await _loginIdentityRepository.read();

    final loginIdentity = existingLoginIdentities.list.singleWhereOrNull(
      (loginIdentity) => loginIdentity.user.id == userId,
    );

    if (loginIdentity == null) {
      throw StateError(
        'User $userId does not resolve to exactly one login identity.',
      );
    }

    final updatedLoginIdentity = loginIdentity.markReauthenticationRequired();

    final updatedLoginIdentities = existingLoginIdentities.copyWith(
      list: existingLoginIdentities.list
          .map(
            (identity) => identity.id == loginIdentity.id
                ? updatedLoginIdentity
                : identity,
          )
          .toList(),
    );

    await _loginIdentityRepository.write(updatedLoginIdentities);

    return updatedLoginIdentities;
  }

  /// Updates the authentication session for the login identity belonging to
  /// [userId] and persists the updated authentication tokens.
  ///
  /// Throws [StateError] if [userId] does not resolve to exactly one login
  /// identity.
  Future<LoginIdentities> updateAuthSession(
    String userId,
    AuthSession authSession,
  ) async {
    final existingLoginIdentities = await _loginIdentityRepository.read();

    final loginIdentity = existingLoginIdentities.list.singleWhereOrNull(
      (loginIdentity) => loginIdentity.user.id == userId,
    );

    if (loginIdentity == null) {
      throw StateError(
        'User $userId does not resolve to exactly one login identity.',
      );
    }

    final updatedLoginIdentity = loginIdentity.withAuthTokens(
      .fromAuthSession(authSession),
    );

    final updatedLoginIdentities = existingLoginIdentities.copyWith(
      list: existingLoginIdentities.list
          .map(
            (identity) => identity.id == loginIdentity.id
                ? updatedLoginIdentity
                : identity,
          )
          .toList(),
    );

    await _loginIdentityRepository.write(updatedLoginIdentities);

    return updatedLoginIdentities;
  }

  /// Returns all locally configured login identities and their associated servers.
  Future<LoginIdentities> read() async {
    return _loginIdentityRepository.read();
  }

  /// Restores the currently selected login identity from [loginIdentities] and
  /// configures the API client with its server and authentication session.
  /// Returns `null` if no login identity is selected.
  ///
  /// Throws [StateError] if the selected login identity or its associated server
  /// does not resolve to exactly one entry in [loginIdentities], or authentication
  /// tokens are not found on a non-browser platform.
  (LoginIdentity, Server)? restoreCurrentLoginIdentity(
    LoginIdentities loginIdentities,
  ) {
    final current = currentLoginIdentity(loginIdentities);
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

  /// Configures the API client with the login identity's server and
  /// authentication session.
  ///
  /// When [LoginIdentity.reauthRequired] is `true`, only the server base URL is
  /// configured because the reauthentication flow does not perform authenticated
  /// API requests, and the UI is expected to require reauthentication before
  /// allowing authenticated API requests.
  ///
  /// Throws [StateError] if authentication tokens are missing while
  /// [loginIdentity] does not require reauthentication on a non-browser
  /// platform.
  void _configureClientFromLoginIdentity(
    LoginIdentity loginIdentity,
    Server server,
  ) {
    _client.setBaseUrl(server.apiBaseUrl);

    if (loginIdentity.reauthRequired) {
      // The reauthentication flow does not perform authenticated API requests.
      return;
    }

    final userId = loginIdentity.user.id;

    final AuthSession authSession = kIsWeb
        ? .browserCookie(userId: userId)
        : loginIdentity.authTokens?.toAuthSession(userId) ??
              (throw StateError(
                'Login identity ${loginIdentity.id} has no persisted '
                'authentication tokens but reauthRequired is false.',
              ));

    _client.setAuthSession(authSession);
  }

  /// Configures the API client with the login identity's server and authentication session.
  void _configureClient(Uri serverBaseUrl, AuthSession authSession) {
    _client.setBaseUrl(serverBaseUrl);
    _client.setAuthSession(authSession);
  }
}

/// The result of completing a login.
@immutable
class const CompleteLoginResult({
  /// The updated login identities.
  required final LoginIdentities loginIdentities,

  /// The login identity that was added or updated.
  required final LoginIdentity loginIdentity,

  /// Whether a new login identity was created.
  required final bool isNew,
});
