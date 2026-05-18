import 'package:meta/meta.dart';

@immutable
class MdnsServiceInfo {
  const MdnsServiceInfo({
    required this.hostname,
    required this.ipAddress,
    required this.port,
    required this.instanceName,
    required this.txtRecords,
  });

  final String hostname;
  final String? ipAddress;
  final int port;
  final String instanceName;
  final Map<String, String>? txtRecords;

  @override
  String toString() =>
      'MdnsServiceInfo(hostname: $hostname, ipAddress: $ipAddress, port: $port, instanceName: $instanceName, txtRecords: $txtRecords)';

  MdnsServiceInfo copyWith({
    String? hostname,
    String? ipAddress,
    int? port,
    String? instanceName,
    Map<String, String>? txtRecords,
  }) {
    return MdnsServiceInfo(
      hostname: hostname ?? this.hostname,
      ipAddress: ipAddress ?? this.ipAddress,
      port: port ?? this.port,
      instanceName: instanceName ?? this.instanceName,
      txtRecords: txtRecords ?? this.txtRecords,
    );
  }
}
