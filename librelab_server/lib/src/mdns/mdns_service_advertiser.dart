import 'package:librelab_server/src/mdns/mdns_driver.dart';
import 'package:librelab_server/src/mdns/mdns_service_config.dart';
import 'package:librelab_shared/librelab_shared.dart';

class MdnsServiceAdvertiser {
  MdnsServiceAdvertiser({required MdnsDriver driver}) : _driver = driver;

  final MdnsDriver _driver;

  Future<void> start({required int port, required String instanceName}) async {
    await _driver.start(
      MdnsServiceConfig(
        instanceName: instanceName,
        port: port,
        serviceType: ProjectConstants.mdnsServiceType,
      ),
    );
  }

  Future<void> stop() async {
    await _driver.stop();
  }
}
