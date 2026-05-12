import 'package:meta/meta.dart';

// TODO: (MDNS) Also provide txt recirds and the server version maybe?

@immutable
final class MdnsServiceConfig {
  const MdnsServiceConfig({
    required this.instanceName,
    required this.port,
    required this.serviceType,
  });

  final String instanceName;
  final int port;
  final String serviceType;
}
