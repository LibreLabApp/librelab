import 'package:meta/meta.dart';

@immutable
class const MdnsServiceInfo({
  required final String hostname,
  required final String? ipAddress,
  required final int port,
  required final String instanceName,
  required final Map<String, String>? txtRecords,
}) {
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
