import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:json_storage/json_storage.dart';
import 'package:librelab_flutter/login_identity/login_identity_repository/auth_secure_storage.dart';
import 'package:librelab_flutter/login_identity/models/login_identities.dart';

/// Manages locally persisted users and their associated servers and
/// authentication credentials. Does not perform authentication or manage
/// in-memory authentication state.
class LoginIdentityRepository({
  required final JsonStorage _storage,
  required final String _storageId,

  required final AuthSecureStorage _secureStorage,
  required final bool _secureStorageAvailable,
}) {
  LoginIdentities? _cached;

  static const LoginIdentities _default = .new(
    selectedLoginIdentityId: null,
    servers: [],
    list: [],
  );

  Future<LoginIdentities> read() async {
    final cached = _cached;
    if (cached != null) {
      return cached;
    }

    final json = await _storage.read(_storageId);

    final LoginIdentities loginIdentities = json != null
        ? .fromJson(json)
        : _default;

    final resolved = await _resolveAuthTokens(loginIdentities);

    _cached = resolved;
    return resolved;
  }

  Future<void> write(LoginIdentities loginIdentities) async {
    await _storage.write(
      _storageId,
      _prepareForPlainStorage(loginIdentities).toJson(),
    );

    if (!kIsWeb && _secureStorageAvailable) {
      await _writeAuthTokensToSecureStorage(loginIdentities);
    }

    _cached = loginIdentities;
  }

  /// Resolves authentication tokens from secure storage for each login identity.
  ///
  /// When secure storage is available, its tokens are the authoritative source.
  /// Missing tokens are resolved as requiring re-authentication.
  ///
  /// [loginIdentities] is the state loaded from persistent storage before
  /// authentication tokens are resolved.
  Future<LoginIdentities> _resolveAuthTokens(
    LoginIdentities loginIdentities,
  ) async {
    final list = loginIdentities.list;

    if ((kIsWeb || !_secureStorageAvailable) || list.isEmpty) {
      return loginIdentities;
    }

    final authTokens = await _secureStorage.read();

    final resolved = list.map((identity) {
      final tokens = authTokens?[identity.user.id];

      if (tokens == null) {
        return identity.markReauthenticationRequired();
      }

      return identity.withAuthTokens(tokens);
    }).toList();

    return loginIdentities.copyWith(list: resolved);
  }

  /// Prepares login identities for persistence in plain storage.
  ///
  /// Authentication tokens are omitted when secure storage is available or on
  /// web. Otherwise, tokens are persisted only when the authentication session
  /// should be persisted.
  LoginIdentities _prepareForPlainStorage(LoginIdentities loginIdentities) {
    // On web platform, authentication session persistence is managed by the
    // browser through HttpOnly cookies.
    if (kIsWeb || _secureStorageAvailable) {
      return loginIdentities.copyWith(
        list: loginIdentities.list
            .map((identity) => identity.withAuthTokens(null))
            .toList(),
      );
    }

    // Respects the user's choice to persist the authentication session.
    return loginIdentities.copyWith(
      list: loginIdentities.list
          .map(
            (identity) => identity.persistAuthSession
                ? identity
                : identity.withAuthTokens(null),
          )
          .toList(),
    );
  }

  /// Writes persisted authentication tokens to secure storage.
  ///
  /// Only authentication tokens for login identities with authentication session
  /// persistence enabled are stored.
  Future<void> _writeAuthTokensToSecureStorage(
    LoginIdentities loginIdentities,
  ) async {
    final AuthTokensByUserId authTokensByUserId = {};

    for (final identity in loginIdentities.list) {
      final tokens = identity.authTokens;

      if (identity.persistAuthSession && tokens != null) {
        authTokensByUserId[identity.user.id] = tokens;
      }
    }

    await _secureStorage.write(authTokensByUserId);
  }
}
