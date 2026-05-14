import 'dart:async';

import 'package:dart_ping/dart_ping.dart';
import 'package:librelab_flutter/local_network_discovery/discovered_server.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';
import 'package:multicast_dns/multicast_dns.dart';

Logger _logger = Logger('$LocalDiscoveryRepository');

class LocalDiscoveryRepository {
  LocalDiscoveryRepository({required MDnsClient mDnsClient})
    : _client = mDnsClient;

  static const _serviceType = ProjectConstants.mdnsServiceType;

  final MDnsClient _client;

  bool _isScanning = false;
  bool get isScanning => _isScanning;

  final List<DiscoveredServer> _servers = [];

  final StreamController<List<DiscoveredServer>> _serversController =
      StreamController.broadcast();
  Stream<List<DiscoveredServer>> get serversStream => _serversController.stream;

  Future<void> _start() async {
    if (_isScanning) {
      throw StateError('Discovery already running');
    }
    _isScanning = true;
    _servers.clear();
    _pushUpdate();

    // TODO: (MDNS) Handle exceptions https://pub.dev/packages/multicast_dns/changelog and https://github.com/flutter/flutter/issues/165482
    //  and macOS permission (://github.com/flutter/packages/pull/8450):  Unhandled Exception: SocketException: Failed to create datagram socket (OS Error: Operation not permitted, errno = 1), address = 0.0.0.0, port = 5353
    await _client.start(
      onError: (Object e) {
        if (e is Error || e is! Exception) {
          // ignore: only_throw_errors
          throw e;
        }
        print('Error: $e');
        // TODO: (MDNS) Handle
      },
    );
  }

  void _stop() {
    _isScanning = false;
    _client.stop();
  }

  Future<void> scan() async {
    await _start();

    // TODO: When using Android airplane mode (caused by lookup(), no WIFI, no mobile data, https://github.com/flutter/flutter/issues/165482):  [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: SocketException: Send failed (OS Error: Network is unreachable, errno = 101), address = 0.0.0.0, port = 5353
    await for (final PtrResourceRecord ptr in _client.lookup<PtrResourceRecord>(
      ResourceRecordQuery.serverPointer(_serviceType),
    )) {
      await for (final SrvResourceRecord srv
          in _client.lookup<SrvResourceRecord>(
            ResourceRecordQuery.service(ptr.domainName),
          )) {
        final host = srv.target;
        final port = srv.port;

        String? rawTxtRecords;

        await for (final TxtResourceRecord txt
            in _client.lookup<TxtResourceRecord>(
              ResourceRecordQuery.text(ptr.domainName),
            )) {
          rawTxtRecords = txt.text;
        }

        await _add(
          host: host,
          port: port,
          instanceName: _stripServiceSuffix(
            domainName: ptr.domainName,
            ptrName: ptr.name,
          ),
          rawTxtRecords: rawTxtRecords,
        );
      }
    }

    _stop();
  }

  Future<void> _add({
    required String host,
    required int port,
    required String instanceName,
    required String? rawTxtRecords,
  }) async {
    final ping = await Ping(host, count: 1).stream.first;
    final pingError = ping.error;
    if (pingError != null) {
      _logger.fine('Ping request failed to "$host": $pingError');
    }

    final txtRecords = rawTxtRecords != null
        ? _parseTxtRecords(rawTxtRecords)
        : null;

    final server = DiscoveredServer(
      instanceName: instanceName,
      localHostname: host,
      port: port,
      pingMs: ping.response?.time?.inMilliseconds,
      serverVersion: txtRecords?['version'],
    );

    final index = _servers.indexWhere((e) => e.uri == server.uri);

    if (index == -1) {
      _servers.add(server);
    } else {
      _servers[index] = server;
    }

    _pushUpdate();
  }

  Map<String, String> _parseTxtRecords(String input) {
    final records = <String, String>{};
    final lines = input.split('\n');

    for (final line in lines) {
      if (line.isEmpty) {
        continue;
      }
      final parts = line.split('=');

      final key = parts.elementAtOrNull(0);
      final value = parts.elementAtOrNull(1);

      if (key == null || value == null) {
        continue;
      }

      records[key] = value;
    }

    return records;
  }

  void _pushUpdate() => _serversController.add(List.unmodifiable(_servers));

  /// Extracts the instance name by removing the service suffix from a full mDNS name.
  ///
  /// ```dart
  /// final instanceName = _stripServiceSuffix(
  ///   domainName: 'LibreLab._librelab._tcp.local',
  ///   ptrName: '._librelab._tcp.local',
  /// );
  ///
  /// print(instanceName); // LibreLab
  /// ```
  String _stripServiceSuffix({
    required String domainName,
    required String ptrName,
  }) {
    final full = domainName; // LibreLab._librelab._tcp.local
    final suffix = '.$ptrName'; // ._librelab._tcp.local

    final instanceName = full.endsWith(suffix)
        ? full.substring(0, full.length - suffix.length)
        : full;
    return instanceName;
  }

  Future<void> close() async {
    await _serversController.close();
    _stop();
  }
}
