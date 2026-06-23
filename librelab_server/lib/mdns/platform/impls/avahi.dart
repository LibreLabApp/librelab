import 'package:librelab_server/mdns/platform/platform_registrar.dart';

/// Uses the system `avahi-publish` command for mDNS service registration.
///
/// Linux counterpart to [DnsSdMdnsRegistrar].
///
/// https://avahi.org/
final class AvahiMdnsRegistrar() extends ProcessMdnsRegistrar {
  this
    : super(
        executable: command,
        buildArguments: (config) {
          final txtRecords = config.txtRecords;
          return [
            '-s',
            config.instanceName,
            config.serviceType,
            '${config.port}',
            ...?txtRecords,
          ];
        },
      );

  static const String command = 'avahi-publish';
}
