import 'package:meta/meta.dart';

// TODO: (MDNS) Another model for the one on disk (presisted)? ping is unncessary and this is just temporary
//  also do we really need uri getter?

@immutable
class DiscoveredServer {
  const DiscoveredServer({
    required this.instanceName,
    required this.localHostname,
    required this.port,
    required this.pingMs,
    required this.serverVersion,
  });

  final String instanceName;
  final String localHostname;
  final int port;
  final int? pingMs;
  final String? serverVersion;

  String get authority => '$localHostname:$port';

  String get id => authority;

  static const int _lowPingThresholdMs = 20;

  bool get hasLowPing => pingMs != null && pingMs! < _lowPingThresholdMs;

  Uri get uri => Uri.http(authority);

  @override
  String toString() =>
      'DiscoveredServer(instanceName: $instanceName, localHostname: $localHostname, port: $port, pingMs: $pingMs, serverVersion: $serverVersion)';
}
