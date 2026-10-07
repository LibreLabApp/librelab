import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_flutter/common/secure_storage/freedesktop_secret_service_checker.dart';

enum SecureStorageAvailability {
  available,
  unavailable;

  bool get isAvailable => switch (this) {
    .available => true,
    .unavailable => false,
  };
}

abstract interface class SecureStorageAvailabilityChecker {
  /// Whether secure storage is currently available on this operating system.
  ///
  /// [SecureStorageAvailability.available] does not guarantee that storage
  /// operations will succeed.
  Future<SecureStorageAvailability> getAvailability();
}

class SecureStorageAvailabilityCheckerImpl({
  required final FreedesktopSecretServiceChecker
  _freedesktopSecretServiceChecker,
}) implements SecureStorageAvailabilityChecker {
  @override
  Future<SecureStorageAvailability> getAvailability() async {
    if (isLinux) {
      return (await _freedesktopSecretServiceChecker.getAvailableServices())
              .hasAvailableService
          ? .available
          : .unavailable;
    }

    return .available;
  }
}
