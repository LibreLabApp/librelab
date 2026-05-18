import 'package:mdns_discovery/mdns_discovery.dart';

sealed class MdnsServiceDiscoveryEvent {
  MdnsServiceDiscoveryEvent({required this.serviceInfo});

  final MdnsServiceInfo serviceInfo;
}

final class Resolved extends MdnsServiceDiscoveryEvent {
  Resolved({required super.serviceInfo});

  @override
  String toString() => 'MdnsServiceDiscoveryEvent.resolved($serviceInfo)';
}

final class Updated extends MdnsServiceDiscoveryEvent {
  Updated({required super.serviceInfo});

  @override
  String toString() => 'MdnsServiceDiscoveryEvent.updated($serviceInfo)';
}

final class Lost extends MdnsServiceDiscoveryEvent {
  Lost({required super.serviceInfo});

  @override
  String toString() => 'MdnsServiceDiscoveryEvent.lost($serviceInfo)';
}
