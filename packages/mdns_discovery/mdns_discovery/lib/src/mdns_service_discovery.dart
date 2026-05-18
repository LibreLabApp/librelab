import 'package:mdns_discovery/src/mdns_service_discovery_event.dart';

abstract interface class MdnsServiceDiscovery {
  /// Start the mDNS client (if applicable).
  ///
  /// Some implementations may depend on platform-specific APIs and may not need
  /// to implement this. Consumers however, should always call it correctly
  /// to allow swapping the implementation at anytime.
  Future<void> start();

  /// Finds mDNS services and resolves their SRV details.
  ///
  /// Note that duplicate messages may come through, especially if any
  /// other mDNS queries are running elsewhere on the machine.
  Stream<MdnsServiceDiscoveryEvent> discoverServices({
    Duration timeout = const Duration(seconds: 5),
  });

  /// Stops the client and close any associated sockets or discover operations.
  Future<void> stop();
}
