import 'dart:async';

import 'package:librelab_flutter/common/network/socket_latency.dart';
import 'package:librelab_flutter/server_selection/local_network_discovery/discovered_server.dart';
import 'package:logging/logging.dart';
import 'package:mdns_discovery/mdns_discovery.dart';

class LocalDiscoveryRepository({
  required final MdnsServiceDiscovery _discovery,
  required final Logger _logger,
}) {
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

  final Duration _timeout = const Duration(seconds: 5);

  /// Must not be called on the web
  Future<void> scan() async {
    if (!_isClientOpen) {
      await _startClient();
    }

    await _onStartScanning();

    await for (final event in _discovery.discoverServices(timeout: _timeout)) {
      final serviceInfo = event.serviceInfo;
      switch (event) {
        case Resolved():
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

    if (txtRecords == null) {
      _logger.warning('($hostname) TXT records for are missing');
    }

    final serverVersion = txtRecords?['version'];
    if (serverVersion == null) {
      _logger.warning('($hostname) server version is missing');
    }

    final server = DiscoveredServer(
      instanceName: instanceName,
      localHostname: hostname,
      ipAddress: info.ipAddress,
      port: port,
      latencyMs: null,
      serverVersion: serverVersion,
    );

    final index = _servers.indexWhere((e) => e.id == server.id);

    if (index == -1) {
      _servers.add(server);
    } else {
      _servers[index] = server;
    }

    _pushUpdate();

    unawaited(_measureLatency(server, hostname: hostname));
  }

  Future<void> _measureLatency(
    DiscoveredServer server, {
    required String hostname,
  }) async {
    final latency = await measureLatency(
      host: server.ipAddress ?? hostname,
      port: server.port,
      logger: _logger,
    );

    final index = _servers.indexWhere((e) => e.id == server.id);
    if (index == -1) {
      return;
    }

    _servers[index] = _servers[index].copyWithLatency(latency?.inMilliseconds);

    _pushUpdate();
  }

  Future<void> _removeServer(MdnsServiceInfo info) async {
    final index = _servers.indexWhere(
      (e) =>
          e.id ==
          DiscoveredServer.getId(localHostname: info.hostname, port: info.port),
    );

    if (index != -1) {
      _servers.removeAt(index);
      _pushUpdate();
    } else {
      _logger.fine('Tried to remove a non-existent server: $info');
    }
  }

  void _pushUpdate() => _serversController.add(.unmodifiableOf(_servers));

  Future<void> close() async {
    await _serversController.close();
    await _onStopScanning();
    await _stopClient();
  }
}
