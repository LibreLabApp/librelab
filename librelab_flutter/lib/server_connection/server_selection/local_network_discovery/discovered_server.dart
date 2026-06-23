import 'package:meta/meta.dart';

// TODO: (MDNS) Another model for the one on disk (presisted)? latency is unncessary and this is just temporary
//  also do we really need uri getter?

@immutable
class const DiscoveredServer({
  required final String instanceName,
  required final String localHostname,
  required final String? ipAddress,
  required final int port,
  required final int? latencyMs,
  required final String? serverVersion,
  required final bool? supportsTls,
}) {
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
