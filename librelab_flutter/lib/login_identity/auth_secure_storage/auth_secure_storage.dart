import 'package:json_safe/json_safe.dart';
import 'package:librelab_flutter/common/secure_storage/secure_storage.dart';
import 'package:librelab_flutter/login_identity/auth_secure_storage/auth_token_values.dart';

/// Provides persistent secure storage for authentication token values.
///
/// The map is keyed by user ID. Each entry contains the access and refresh
/// token values for that user.
abstract interface class AuthSecureStorage {
  Future<Map<String, AuthTokenValues>?> read();
  Future<void> write(Map<String, AuthTokenValues> tokens);
}

class AuthSecureStorageImpl({required final SecureStorage _secureStorage})
    implements AuthSecureStorage {
  static const _storageKey = 'auth_tokens';

  @override
  Future<Map<String, AuthTokenValues>?> read() async {
    final value = await _secureStorage.read(_storageKey);
    if (value == null) {
      return null;
    }
    return deserializeJson(
      value,
      (json) => json.map(
        (userId, value) =>
            MapEntry(userId, AuthTokenValues.fromJson(value! as JsonMap)),
      ),
    );
  }

  @override
  Future<void> write(Map<String, AuthTokenValues> tokens) async {
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
