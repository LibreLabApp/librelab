import 'package:librelab_server/mdns/platform/platform_registrar.dart';

/// Uses the system `dns-sd` command for mDNS service registration.
///
/// - macOS: `dns-sd` is built-in.
/// - Windows: requires installation of [Bonjour Services](https://support.apple.com/en-us/106380):
/// (install only `Bonjour64.msi`, which is inside `BonjourPSSetup.exe` file)
///
/// https://developer.apple.com/documentation/dnssd
final class DnsSdMdnsRegistrar() extends ProcessMdnsRegistrar {
  this
    : super(
        executable: command,
        buildArguments: (config) {
          final txtRecords = config.txtRecords;
          return [
            '-R',
            config.instanceName,
            config.serviceType,
            '.',
            '${config.port}',
            ...?txtRecords,
          ];
        },
      );
  static const String command = 'dns-sd';
}
