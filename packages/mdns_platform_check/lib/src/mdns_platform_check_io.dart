import 'dart:io' show Platform;

import 'package:dbus/dbus.dart';
import 'package:is_ios_simulator/is_ios_simulator.dart';
import 'package:mdns_platform_check/src/mdns_platform_check_android.g.dart';
import 'package:win32/win32.dart' as win32;

typedef DBusClientFactory = DBusClient Function();

class MdnsPlatformCheck({
  final DBusClientFactory _dBusClientFactory = DBusClient.system,
}) {
  /// Detects whether the current platform exposes native APIs for mDNS service
  /// advertising and discovery.
  Future<bool> supportsPlatformApi() async {
    if (Platform.isLinux) {
      return _supportsAvahiViaDbus();
    }
    if (Platform.isWindows) {
      return win32.OsVersion.current >= .win10v1903;
    }
    if (Platform.isIOS) {
      if (await isIosSimulator()) {
        return false;
      }
      return true;
    }
    if (Platform.isMacOS) {
      return true;
    }
    if (Platform.isAndroid) {
      return Build$VERSION.SDK_INT >= Build$VERSION_CODES.R &&
          SdkExtensions.getExtensionVersion(Build$VERSION_CODES.TIRAMISU) >= 17;
    }

    throw UnsupportedError(
      'Unsupported operating system: ${Platform.operatingSystem}',
    );
  }

  Future<bool> _supportsAvahiViaDbus() async {
    final client = _dBusClientFactory();

    try {
      return await client.nameHasOwner('org.freedesktop.Avahi');
    } on DBusMethodResponseException {
      return false;
    } finally {
      await client.close();
    }
  }
}
