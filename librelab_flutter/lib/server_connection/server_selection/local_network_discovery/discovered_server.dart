import 'package:meta/meta.dart';

// TODO: (MDNS) Another model for the one on disk (presisted)? latency is unncessary and this is just temporary
//  also do we really need uri getter?

@immutable
class DiscoveredServer {
  const DiscoveredServer({
    required this.instanceName,
    required this.localHostname,
    required this.ipAddress,
    required this.port,
    required this.latencyMs,
    required this.serverVersion,
    required this.supportsTls,
  });

  final String instanceName;
  final String localHostname;
  final String? ipAddress;
  final int port;
  final int? latencyMs;
  final String? serverVersion;
  final bool? supportsTls;

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

  // TODO: Finish from here, should we default to false somehwere else?
  Uri get uri =>
      (supportsTls ?? false) ? Uri.https(authority) : Uri.http(authority);

  @override
  String toString() =>
      'DiscoveredServer(instanceName: $instanceName, localHostname: $localHostname, ipAddress: $ipAddress, port: $port, latencyMs: $latencyMs, serverVersion: $serverVersion, supportsTls: $supportsTls)';
}
