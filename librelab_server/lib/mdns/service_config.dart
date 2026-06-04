import 'package:meta/meta.dart';

@immutable
final class MdnsServiceConfig {
  const MdnsServiceConfig({
    required this.instanceName,
    required this.port,
    required this.serviceType,
    required this.txtRecords,
  });

  final String instanceName;
  final int port;
  final String serviceType;
  final List<String>? txtRecords;
}
