import 'package:librelab_server/src/mdns/installer/mdns_platform_installer.dart';

/// Does not need mDNS service installation (dns-sd is already installed).
final class MacOsNoOpMdnsInstaller implements MdnsPlatformInstaller {
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
