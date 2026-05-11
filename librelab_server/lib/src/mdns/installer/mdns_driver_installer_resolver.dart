import 'package:librelab_server/src/mdns/installer/mdns_platform_installer.dart';
import 'package:librelab_server/src/mdns/installer/platforms/linux.dart';
import 'package:librelab_server/src/mdns/installer/platforms/macos.dart';
import 'package:librelab_server/src/mdns/installer/platforms/windows.dart';
import 'package:librelab_server/src/utils/platform_check.dart';

Future<MdnsPlatformInstaller?> resolveMdnsPlatformInstaller() async =>
    switch (currentDesktopPlatform) {
      DesktopPlatform.linux => () async {
        final packageManager = await LinuxAvahiInstaller.systemPackageManager();
        if (packageManager == null) {
          return null;
        }
        return LinuxAvahiInstaller(packageManager: packageManager);
      }(),
      DesktopPlatform.macOS => MacOsNoOpMdnsInstaller(),
      DesktopPlatform.windows => WindowsBonjourInstaller(),
    };
