import 'package:mdns_discovery/mdns_discovery.dart';

sealed class MdnsServiceDiscoveryEvent {
  new({required this.serviceInfo});

  final MdnsServiceInfo serviceInfo;
}

final class Resolved extends MdnsServiceDiscoveryEvent {
  new({required super.serviceInfo});

  @override
  String toString() => 'MdnsServiceDiscoveryEvent.resolved($serviceInfo)';
}

final class Updated extends MdnsServiceDiscoveryEvent {
  new({required super.serviceInfo});

  @override
  String toString() => 'MdnsServiceDiscoveryEvent.updated($serviceInfo)';
}

final class Lost extends MdnsServiceDiscoveryEvent {
  new({required super.serviceInfo});

  @override
  String toString() => 'MdnsServiceDiscoveryEvent.lost($serviceInfo)';
}
