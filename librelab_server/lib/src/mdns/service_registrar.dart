import 'package:librelab_server/generated/pubspec.g.dart';
import 'package:librelab_server/src/mdns/platform/platform_registrar.dart';
import 'package:librelab_server/src/mdns/service_config.dart';
import 'package:librelab_shared/librelab_shared.dart';

/// Registers and publishes the application mDNS service on the local network.
///
/// Most implementations allow the service to be resolved through a `.local`
/// hostname. The fallback implementation may only advertise the service
/// (i.e., Bonjour is not installed on Windows, or Avahi on Linux).
class MdnsServiceRegistrar {
  MdnsServiceRegistrar({required MdnsPlatformRegistrar platform})
    : _platform = platform;

  final MdnsPlatformRegistrar _platform;
  bool _isRegistered = false;

  /// Starts publishing the mDNS service on the local network.
  Future<void> start({required int port, required String instanceName}) async {
    if (_isRegistered) {
      throw StateError(
        'start() must not be called when the mDNS service is already registered.',
      );
    }
    await _platform.start(
      MdnsServiceConfig(
        instanceName: instanceName,
        port: port,
        serviceType: ProjectConstants.mdnsServiceType,
        txtRecords: const ['version=${Pubspec.version}'],
      ),
    );
    _isRegistered = true;
  }

  /// Stops publishing and unregisters the mDNS service.
  Future<void> stop() async {
    await _platform.stop();
    _isRegistered = false;
  }
}
