import 'package:librelab_server/mdns/installer/platform_installer.dart';
import 'package:librelab_server/mdns/installer/platforms/linux.dart';
import 'package:librelab_server/mdns/installer/platforms/macos.dart';
import 'package:librelab_server/mdns/installer/platforms/windows.dart';
import 'package:librelab_server/utils/platform_check.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';

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
