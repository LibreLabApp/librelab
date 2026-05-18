import 'dart:async';

import 'package:dart_ping/dart_ping.dart';
import 'package:librelab_flutter/server_connection/local_network_discovery/discovered_server.dart';
import 'package:logging/logging.dart';
import 'package:mdns_discovery/mdns_discovery.dart';

Logger _logger = Logger('$LocalDiscoveryRepository');

class LocalDiscoveryRepository {
  LocalDiscoveryRepository({required MdnsServiceDiscovery discovery})
    : _discovery = discovery;

  final MdnsServiceDiscovery _discovery;

  bool _isScanning = false;
  bool get isScanning => _isScanning;

  final List<DiscoveredServer> _servers = [];

  final StreamController<List<DiscoveredServer>> _serversController =
      StreamController.broadcast();
  Stream<List<DiscoveredServer>> get serversStream => _serversController.stream;

  bool _isClientOpen = false;

  Future<void> _startClient() async {
    await _discovery.start();
    _isClientOpen = true;
  }

  Future<void> _stopClient() async {
    await _discovery.stop();
    _isClientOpen = false;
  }

  Future<void> _onStartScanning() async {
    if (_isScanning) {
      throw StateError('Discovery already running');
    }
    _isScanning = true;
    _servers.clear();
    _pushUpdate();
  }

  Future<void> _onStopScanning() async {
    _isScanning = false;
  }

  Future<void> scan() async {
    if (!_isClientOpen) {
      await _startClient();
    }

    await _onStartScanning();

    await for (final event in _discovery.discoverServices()) {
      final serviceInfo = event.serviceInfo;
      switch (event) {
        case Resolved():
          await _upsertServer(serviceInfo);
        case Updated():
          await _upsertServer(serviceInfo);
        case Lost():
          await _removeServer(serviceInfo);
      }
    }

    await _onStopScanning();
  }

  Future<void> _upsertServer(MdnsServiceInfo info) async {
    final (hostname, ipAddress, port, instanceName, txtRecords) = (
      info.hostname,
      info.ipAddress,
      info.port,
      info.instanceName,
      info.txtRecords,
    );

    final ping = await Ping(hostname, count: 1).stream.first;
    final pingError = ping.error;

    // Ping may fail if the host (e.g., Windows) disallows pinging
    // OR if the client is Windows and Bonjour is not installed
    if (pingError != null) {
      _logger.fine('Ping request failed to "$hostname": $pingError');
    } else if (ping.response == null) {
      _logger.fine('Ping request failed to "$hostname" with no error: $ping');
    }

    final server = DiscoveredServer(
      instanceName: instanceName,
      localHostname: hostname,
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

  Future<void> _removeServer(MdnsServiceInfo info) async {
    final serverUri = Uri.http(
      DiscoveredServer.getAuthority(
        localHostname: info.hostname,
        port: info.port,
      ),
    );
    final index = _servers.indexWhere((e) => e.uri == serverUri);

    if (index != -1) {
      _servers.removeAt(index);
      _pushUpdate();
    } else {
      _logger.fine('Tried to remove a non-existent server: $info');
    }
  }

  void _pushUpdate() => _serversController.add(List.unmodifiable(_servers));

  Future<void> close() async {
    await _serversController.close();
    await _onStopScanning();
    await _stopClient();
  }
}
