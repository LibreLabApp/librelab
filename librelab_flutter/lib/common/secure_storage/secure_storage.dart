import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_flutter/common/secure_storage/freedesktop_secret_service_checker.dart';

abstract interface class SecureStorage {
  /// Whether secure storage is currently available on this operating system.
  Future<bool> isAvailable();

  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);
}

class SecureStorageImpl({
  required final FreedesktopSecretServiceChecker
  _freedesktopSecretServiceChecker,
  required final FlutterSecureStorage _flutterSecureStorage,
}) implements SecureStorage {
  @override
  Future<bool> isAvailable() async {
    if (isLinux) {
      return await _freedesktopSecretServiceChecker
              .isSecretServiceAvailable() ||
          await _freedesktopSecretServiceChecker.isSecretPortalAvailable();
    }

    return true;
  }

  @override
  Future<String?> read(String key) => _flutterSecureStorage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _flutterSecureStorage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _flutterSecureStorage.delete(key: key);
}
