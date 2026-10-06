import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:dbus/dbus.dart';

/// Checks whether the freedesktop.org secret storage services are available.
///
/// These services are commonly provided on Linux desktop systems and are used by
/// applications for secure storage of sensitive data.
abstract interface class FreedesktopSecretServiceChecker {
  Future<bool> isSecretServiceAvailable();
  Future<bool> isSecretPortalAvailable();
}

typedef DBusClientProvider = FutureOr<DBusClient> Function();

class FreedesktopSecretServiceCheckerImpl
    implements FreedesktopSecretServiceChecker {
  FreedesktopSecretServiceCheckerImpl({DBusClientProvider? dbusClientProvider})
    : _dbusClientProvider = dbusClientProvider ?? DBusClient.session,
      _ownsClient = dbusClientProvider == null;

  final DBusClientProvider _dbusClientProvider;
  final bool _ownsClient;

  @override
  Future<bool> isSecretServiceAvailable() =>
      _isDBusAvailable('org.freedesktop.secrets');

  @override
  Future<bool> isSecretPortalAvailable() =>
      _isDBusAvailable('org.freedesktop.portal.Secret');

  Future<bool> _isDBusAvailable(String name) async {
    final dbusClient = await _dbusClientProvider();
    try {
      return await dbusClient.nameHasOwner(name);
    } finally {
      if (_ownsClient) {
        await dbusClient.close();
      }
    }
  }
}
