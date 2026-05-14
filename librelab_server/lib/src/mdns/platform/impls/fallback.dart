import 'package:librelab_server/src/mdns/platform/platform_registrar.dart';
import 'package:librelab_server/src/mdns/service_config.dart';
import 'package:mdns_dart/mdns_dart.dart' as mdns_dart;

/// Uses the [mdns_dart](https://pub.dev/packages/mdns_dart) package.
///
/// Known issues (at least according to Ellet's testing):
///
/// - macOS: Throws during socket initialization with:
///   `Bad state: Failed to create any multicast sockets`
///
/// - Linux/Windows: May start successfully.
///   OS-level .local hostname resolution is not functional
///   (e.g., no responses or `null` ping results in clients).
///
/// This implementation should be used as a fallback in
/// case there are other implementations.
final class FallbackMdnsRegistrar implements MdnsPlatformRegistrar {
  mdns_dart.MDNSServer? _server;

  @override
  Future<void> start(MdnsServiceConfig config) async {
    final service = await mdns_dart.MDNSService.create(
      instance: config.instanceName,
      service: config.serviceType,
      port: config.port,
      txt: config.txtRecords ?? [],
    );
    _server = mdns_dart.MDNSServer(mdns_dart.MDNSServerConfig(zone: service));
    await _server!.start();
  }

  @override
  Future<void> stop() async {
    await _server?.stop();
    _server = null;
  }
}
