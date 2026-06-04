import 'package:librelab_server/src/mdns/installer/platform_installer.dart';
import 'package:librelab_server/src/mdns/installer/platforms/linux.dart';
import 'package:librelab_server/src/mdns/installer/platforms/macos.dart';
import 'package:librelab_server/src/mdns/installer/platforms/windows.dart';
import 'package:librelab_server/src/utils/platform_check.dart';
import 'package:librelab_server/src/utils/shutdown/shutdown.dart';

Future<MdnsPlatformInstaller?> resolveMdnsPlatformInstaller({
  required Shutdown shutdown,
}) async => switch (currentDesktopPlatform) {
  DesktopPlatform.linux => () async {
    final packageManager = await AvahiLinuxInstaller.systemPackageManager();
    if (packageManager == null) {
      return null;
    }
    return AvahiLinuxInstaller(
      packageManager: packageManager,
      shutdown: shutdown,
    );
  }(),
  DesktopPlatform.macOS => MacOsNoopMdnsInstaller(),
  DesktopPlatform.windows => BonjourWindowsInstaller(shutdown: shutdown),
};
