import 'dart:async';

import 'package:librelab_flutter/common/io_utils.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/discovered_server.dart';
import 'package:logging/logging.dart';
import 'package:mdns_discovery/mdns_discovery.dart';

class LocalDiscoveryRepository {
  LocalDiscoveryRepository({required this._discovery, required this._logger});

  final MdnsServiceDiscovery _discovery;
  final Logger _logger;

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

  final Duration _timeout = const Duration(seconds: 7);

  Future<void> scan() async {
    if (!_isClientOpen) {
      await _startClient();
    }

    await _onStartScanning();

    await for (final event in _discovery.discoverServices(timeout: _timeout)) {
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

    final Duration? latency = await measureLatency(
      ipAddress ?? hostname,
      port,
      logger: _logger,
    );

    if (txtRecords == null) {
      _logger.warning('($hostname) TXT records for are missing');
    }

    final server = DiscoveredServer(
      instanceName: instanceName,
      localHostname: hostname,
      ipAddress: info.ipAddress,
      port: port,
      latencyMs: latency?.inMilliseconds,
      serverVersion: txtRecords?['version'],
      supportsTls: () {
        if (txtRecords == null) {
          return null;
        }

        const key = 'supportsTls';
        final record = txtRecords[key];
        if (record == null) {
          _logger.warning('($hostname) $key TXT record is missing.');
          return null;
        }
        final parsed = bool.tryParse(record);
        if (parsed == null) {
          _logger.warning(
            '($hostname) Invalid TXT record for $key',
            'Expected "true" or "false", got "$record"',
          );
        }
        return parsed;
      }(),
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
