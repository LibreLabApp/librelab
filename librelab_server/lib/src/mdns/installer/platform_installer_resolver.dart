import 'package:librelab_server/src/mdns/installer/platform_installer.dart';
import 'package:librelab_server/src/mdns/installer/platforms/linux.dart';
import 'package:librelab_server/src/mdns/installer/platforms/macos.dart';
import 'package:librelab_server/src/mdns/installer/platforms/windows.dart';
import 'package:librelab_server/src/utils/platform_check.dart';

Future<MdnsPlatformInstaller?> resolveMdnsPlatformInstaller() async =>
    switch (currentDesktopPlatform) {
      DesktopPlatform.linux => () async {
        final packageManager = await AvahiLinuxInstaller.systemPackageManager();
        if (packageManager == null) {
          return null;
        }
        return AvahiLinuxInstaller(packageManager: packageManager);
      }(),
      DesktopPlatform.macOS => MacOsNoopMdnsInstaller(),
      DesktopPlatform.windows => BonjourWindowsInstaller(),
    };
