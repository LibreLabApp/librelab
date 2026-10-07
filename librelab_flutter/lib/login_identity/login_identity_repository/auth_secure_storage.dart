import 'package:json_safe/json_safe.dart';
import 'package:librelab_flutter/common/secure_storage/secure_storage.dart';
import 'package:librelab_flutter/login_identity/models/login_identity.dart';

/// Authentication tokens keyed by user ID.
typedef AuthTokensByUserId = Map<String, AuthTokens>;

/// Provides persistent secure storage for authentication token values.
///
/// The map is keyed by user ID. Each entry contains the access and refresh
/// token values for that user.
abstract interface class AuthSecureStorage {
  Future<AuthTokensByUserId?> read();
  Future<void> write(AuthTokensByUserId tokens);
}

class AuthSecureStorageImpl({required final SecureStorage _secureStorage})
    implements AuthSecureStorage {
  static const _storageKey = 'auth_tokens';

  @override
  Future<AuthTokensByUserId?> read() async {
    final value = await _secureStorage.read(_storageKey);
    if (value == null) {
      return null;
    }
    return deserializeJson(
      value,
      (json) => json.map(
        (userId, value) =>
            MapEntry(userId, AuthTokens.fromJson(value! as JsonMap)),
      ),
    );
  }

  @override
  Future<void> write(AuthTokensByUserId tokens) async {
    await _secureStorage.write(
      _storageKey,
      jsonEncode(
        tokens.map(
          (userId, tokenValues) => MapEntry(userId, tokenValues.toJson()),
        ),
      ),
    );
  }
}
