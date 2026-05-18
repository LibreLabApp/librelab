import 'dart:io';

import 'package:logging/logging.dart';
import 'package:mdns_discovery/mdns_discovery.dart';
import 'package:multicast_dns/multicast_dns.dart';

// Allow consumers to create a MDnsClient without directly adding
// the multicast_dns dependency.
export 'package:multicast_dns/multicast_dns.dart' show MDnsClient;

class RawMdnsServiceDiscovery implements MdnsServiceDiscovery {
  RawMdnsServiceDiscovery({
    required MDnsClient client,
    required String serviceType,
    required Logger logger,
  }) : _logger = logger,
       _serviceType = serviceType,
       _client = client;

  final MDnsClient _client;
  final String _serviceType;
  final Logger _logger;

  @override
  Stream<MdnsServiceDiscoveryEvent> discoverServices({
    Duration timeout = const Duration(seconds: 5),
  }) async* {
    // TODO: Must check network reachbility before calling this .lookup() on Android! (https://github.com/flutter/flutter/issues/165482):  [ERROR:flutter/runtime/dart_vm_initializer.cc(40)]
    await for (final ptr in _client.lookup<PtrResourceRecord>(
      ResourceRecordQuery.serverPointer(_serviceType),
      timeout: timeout,
    )) {
      await for (final srv in _client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName),
      )) {
        final hostname = srv.target;
        final port = srv.port;

        String? rawTxtRecords;

        await for (final txt in _client.lookup<TxtResourceRecord>(
          ResourceRecordQuery.text(ptr.domainName),
        )) {
          rawTxtRecords = txt.text;
        }

        final txtRecords = rawTxtRecords != null
            ? _parseTxtRecords(rawTxtRecords)
            : null;

        String? ipAddress;

        await for (final ip in _client.lookup<IPAddressResourceRecord>(
          ResourceRecordQuery.addressIPv4(srv.target),
        )) {
          ipAddress = ip.address.address;
        }

        final serviceInfo = MdnsServiceInfo(
          hostname: hostname,
          port: port,
          ipAddress: ipAddress,
          instanceName: _stripServiceSuffix(
            domainName: ptr.domainName,
            ptrName: ptr.name,
          ),
          txtRecords: txtRecords,
        );

        yield Resolved(serviceInfo: serviceInfo);
      }
    }
  }

  @override
  Future<void> start() async {
    // TODO: (MDNS) Handle exceptions https://pub.dev/packages/multicast_dns/changelog and https://github.com/flutter/flutter/issues/165482
    //  and macOS permission (://github.com/flutter/packages/pull/8450):  Unhandled Exception: SocketException: Failed to create datagram socket (OS Error: Operation not permitted, errno = 1), address = 0.0.0.0, port = 5353

    _logger.fine('Starting the mDNS client');

    await _client.start(
      onError: (Object e) {
        if (e is Error || e is! Exception) {
          // Handle only "Exception"s, otherwise rethrow
          // ignore: only_throw_errors
          throw e;
        }

        if (e is SocketException) {
          final osError = e.osError;

          if (Platform.isAndroid && osError != null) {
            // https://github.com/flutter/flutter/issues/165482
            // ```console
            // Unhandled Exception: SocketException: Send failed (OS Error: Network is unreachable, errno = 101), address = 0.0.0.0, port = 5353
            // ```
            final isNetworkUnreachable =
                osError.errorCode == 101 ||
                osError.message == 'Network is unreachable';
            if (isNetworkUnreachable) {
              // TODO: (MDNS) Handle properly!
              _logger.severe(
                'Network is unreachable. This may happen if Wi-Fi or Mobile data are likely disabled (Android only)',
              );
              return;
            }
          }
        }

        throw e;
      },
    );
    _logger.fine('The mDNS client has been started');
  }

  @override
  Future<void> stop() async {
    _logger.fine('Stopping the mDNS client');
    _client.stop();
    _logger.fine('The mDNS client has been stopped');
  }
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
