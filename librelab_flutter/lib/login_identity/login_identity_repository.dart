import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:json_storage/json_storage.dart';
import 'package:librelab_flutter/login_identity/models/login_identities.dart';

// TODO: (AUTH) Store tokens on system secure storage when supported (non-browser platforms)

/// Manages locally persisted users and their associated servers and
/// authentication credentials. Does not perform authentication or manage
/// in-memory authentication state.
class LoginIdentityRepository({
  required final JsonStorage _storage,
  required final String _storageId,
}) {
  LoginIdentities? _cached;

  Future<LoginIdentities> read() async {
    final cached = _cached;
    if (cached != null) {
      return cached;
    }

    final json = await _storage.read(_storageId);

    final LoginIdentities loginIdentities = json == null
        ? const .new(
            selectedLoginIdentityId: null,
            servers: [],
            loginIdentities: [],
          )
        : .fromJson(json);

    _cached = loginIdentities;
    return loginIdentities;
  }

  Future<void> write(LoginIdentities root) async {
    // Respects the user's choice to persist the authentication session.
    // On web platform, authentication session persistence is managed by the
    // browser through HttpOnly cookies.
    final persistedLoginIdentities = root.loginIdentities.map((loginIdentity) {
      if (kIsWeb || !loginIdentity.persistAuthSession) {
        return loginIdentity.withAuthTokens(null);
      }
      return loginIdentity;
    }).toList();

    final updated = root.copyWith(loginIdentities: persistedLoginIdentities);

    await _storage.write(_storageId, updated.toJson());

    _cached = updated;
  }
}
