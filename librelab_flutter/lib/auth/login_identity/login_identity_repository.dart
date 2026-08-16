import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:json_storage/json_storage.dart';
import 'package:librelab_flutter/auth/login_identity/models/login_identities.dart';

// TODO: (AUTH) Store tokens on system secure storage when supported (non-browser platforms)

/// Manages locally persisted users and their associated servers and
/// authentication credentials. Does not perform authentication or manage
/// in-memory authentication state.
class LoginIdentityRepository(
  final JsonStorage _storage,
  final String _storageId,
) {
  Future<LoginIdentities> read() async {
    final json = await _storage.read(_storageId);
    if (json == null) {
      return const .new(
        selectedLoginIdentityId: null,
        servers: [],
        loginIdentities: [],
      );
    }
    return .fromJson(json);
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

    await _storage.write(
      _storageId,
      root.copyWith(loginIdentities: persistedLoginIdentities).toJson(),
    );
  }
}
