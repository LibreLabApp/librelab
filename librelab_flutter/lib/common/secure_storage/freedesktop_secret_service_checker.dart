import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:dbus/dbus.dart';

/// These services are commonly provided on Linux desktop systems and are used by
/// applications for secure storage of sensitive data.
enum FreedesktopSecretService { secretService, secretPortal }

/// Checks which freedesktop.org secret storage services are available.
///
/// Returns the available secret storage services provided by the current
/// Linux desktop session.
abstract interface class FreedesktopSecretServiceChecker {
  Future<Set<FreedesktopSecretService>> getAvailableServices();
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
  Future<Set<FreedesktopSecretService>> getAvailableServices() async {
    final dbusClient = await _dbusClientProvider();
    try {
      final results = await Future.wait([
        dbusClient.nameHasOwner('org.freedesktop.secrets'),
        dbusClient.nameHasOwner('org.freedesktop.portal.Secret'),
      ]);

      return {if (results[0]) .secretService, if (results[1]) .secretPortal};
    } finally {
      if (_ownsClient) {
        await dbusClient.close();
      }
    }
  }
}

extension FreedesktopSecretServicesX on Set<FreedesktopSecretService> {
  bool get hasAvailableService => isNotEmpty;
  bool get hasSecretPortalWithoutSecretService =>
      contains(FreedesktopSecretService.secretPortal) &&
      !contains(FreedesktopSecretService.secretService);
}
