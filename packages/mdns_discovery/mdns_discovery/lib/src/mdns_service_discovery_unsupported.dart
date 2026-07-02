import 'package:mdns_discovery/src/mdns_service_discovery.dart';
import 'package:mdns_discovery/src/mdns_service_discovery_event.dart';

class const MdnsServiceDiscoveryUnsupported() implements MdnsServiceDiscovery {
  UnsupportedError _error() => UnsupportedError(
    'mDNS service discovery is not supported on this platform.',
  );

  @override
  Future<void> start() => throw _error();

  @override
  Stream<MdnsServiceDiscoveryEvent> discoverServices({
    Duration timeout = const Duration(seconds: 5),
  }) => throw _error();

  @override
  Future<void> stop() => throw _error();
}
