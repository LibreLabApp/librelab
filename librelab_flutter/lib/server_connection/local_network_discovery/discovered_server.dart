import 'package:meta/meta.dart';

// TODO: (MDNS) Another model for the one on disk (presisted)? latency is unncessary and this is just temporary
//  also do we really need uri getter?

@immutable
class DiscoveredServer {
  const DiscoveredServer({
    required this.instanceName,
    required this.localHostname,
    required this.port,
    required this.latencyMs,
    required this.serverVersion,
  });

  final String instanceName;
  final String localHostname;
  final int port;
  final int? latencyMs;
  final String? serverVersion;

  String get authority =>
      getAuthority(localHostname: localHostname, port: port);

  static String getAuthority({
    required String localHostname,
    required int port,
  }) {
    return '$localHostname:$port';
  }

  String get id => authority;

  static const int _lowLatencyThresholdMs = 20;

  bool get hasLowLatency =>
      latencyMs != null && latencyMs! < _lowLatencyThresholdMs;

  Uri get uri => Uri.http(authority);

  @override
  String toString() =>
      'DiscoveredServer(instanceName: $instanceName, localHostname: $localHostname, port: $port, latencyMs: $latencyMs, serverVersion: $serverVersion)';
}
