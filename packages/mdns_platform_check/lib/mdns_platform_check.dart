import 'package:dbus/dbus.dart';
import 'package:mdns_platform_check/src/mdns_platform_check_android.g.dart';
import 'package:platform/platform.dart';
import 'package:win32/win32.dart' as win32;

typedef DBusClientFactory = DBusClient Function();

class MdnsPlatformCheck {
  MdnsPlatformCheck({Platform? platform, DBusClientFactory? dBusClientFactory})
    : _dBusClientFactory = dBusClientFactory ?? DBusClient.system,
      _platform = platform ?? const LocalPlatform();

  final Platform _platform;
  final DBusClientFactory _dBusClientFactory;

  /// Detects whether the current platform exposes native APIs for mDNS service
  /// advertising and discovery.
  Future<bool> supportsPlatformApi() async {
    if (_platform.isLinux) {
      return _supportsAvahiViaDbus();
    }
    if (_platform.isWindows) {
      return win32.OsVersion.current >= .win10v1903;
    }
    if (_platform.isIOS || _platform.isMacOS) {
      return true;
    }
    if (_platform.isAndroid) {
      return Build$VERSION.SDK_INT >= Build$VERSION_CODES.R &&
          SdkExtensions.getExtensionVersion(Build$VERSION_CODES.TIRAMISU) >= 17;
    }

    throw UnsupportedError(
      'Unsupported operating system: ${_platform.operatingSystem}',
    );
  }

  Future<bool> _supportsAvahiViaDbus() async {
    final client = _dBusClientFactory();

    try {
      final owner = await client.getNameOwner('org.freedesktop.Avahi');
      return owner != null && owner.isNotEmpty;
    } on DBusMethodResponseException {
      return false;
    } finally {
      await client.close();
    }
  }
}
