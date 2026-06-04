import 'package:librelab_server/mdns/installer/platform_installer.dart';

/// Does not need mDNS service installation (dns-sd is already installed).
final class MacOsNoopMdnsInstaller implements MdnsPlatformInstaller {
  @override
  Future<void> install() {
    throw UnsupportedError(
      'macOS already provides "dns-sd" command by default and does not require any installation',
    );
  }

  @override
  Future<bool> isInstalled() async => true;

  @override
  String get promptMessage => throw UnsupportedError('Not applicable');
}
