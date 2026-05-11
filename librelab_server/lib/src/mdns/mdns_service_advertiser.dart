import 'package:librelab_server/src/mdns/mdns_driver.dart';
import 'package:librelab_server/src/mdns/mdns_service_config.dart';
import 'package:librelab_shared/librelab_shared.dart';

class MdnsServiceAdvertiser {
  MdnsServiceAdvertiser({required MdnsDriver driver}) : _driver = driver;

  final MdnsDriver _driver;
  bool _isAdvertising = false;

  Future<void> start({required int port, required String instanceName}) async {
    if (_isAdvertising) {
      throw StateError(
        'start() must not be called when already advertising the mDNS service.',
      );
    }
    await _driver.start(
      MdnsServiceConfig(
        instanceName: instanceName,
        port: port,
        serviceType: ProjectConstants.mdnsServiceType,
      ),
    );
    _isAdvertising = true;
  }

  Future<void> stop() async {
    await _driver.stop();
    _isAdvertising = false;
  }
}
