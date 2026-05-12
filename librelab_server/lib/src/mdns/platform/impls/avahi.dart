import 'package:librelab_server/src/mdns/platform/platform_registrar.dart';

/// Uses the system `avahi-publish` command for mDNS service registration.
///
/// Linux counterpart to [DnsSdMdnsRegistrar].
///
/// https://avahi.org/
final class AvahiMdnsRegistrar extends ProcessMdnsRegistrar {
  AvahiMdnsRegistrar()
    : super(
        executable: command,
        buildArguments: (config) => [
          '-s',
          config.instanceName,
          config.serviceType,
          '${config.port}',
        ],
      );

  static const String command = 'avahi-publish';
}
