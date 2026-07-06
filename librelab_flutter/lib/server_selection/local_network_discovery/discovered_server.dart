import 'package:meta/meta.dart';

// TODO: (MDNS) Another model for the one on disk (presisted)?

@immutable
class const DiscoveredServer({
  required final String instanceName,
  required final String localHostname,
  required final String? ipAddress,
  required final int port,
  required final int? latencyMs,
  required final String? serverVersion,
}) {
  String get authority => _getAuthority(host: localHostname, port: port);
  String? get ipAddressAuthority {
    final ipAddress = this.ipAddress;
    return ipAddress != null
        ? _getAuthority(host: ipAddress, port: port)
        : null;
  }

  static String _getAuthority({required String host, required int port}) {
    return '$host:$port';
  }

  String get id => authority;

  static String getId({required String localHostname, required int port}) {
    return _getAuthority(host: localHostname, port: port);
  }

  static const int _lowLatencyThresholdMs = 20;

  bool get hasLowLatency =>
      latencyMs != null && latencyMs! < _lowLatencyThresholdMs;

  @override
  String toString() =>
      'DiscoveredServer(instanceName: $instanceName, localHostname: $localHostname, ipAddress: $ipAddress, port: $port, latencyMs: $latencyMs, serverVersion: $serverVersion)';

  DiscoveredServer copyWithLatency(int? updated) => .new(
    instanceName: instanceName,
    localHostname: localHostname,
    ipAddress: ipAddress,
    port: port,
    latencyMs: updated,
    serverVersion: serverVersion,
  );
}
