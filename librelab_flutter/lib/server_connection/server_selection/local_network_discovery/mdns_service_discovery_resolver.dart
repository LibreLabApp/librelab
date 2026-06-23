import 'dart:io' show Platform, RawDatagramSocket;

import 'package:collection/collection.dart';
import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';
import 'package:mdns_discovery/mdns_discovery.dart';
import 'package:mdns_discovery_bonsoir/mdns_discovery_bonsoir.dart';
import 'package:mdns_discovery_raw/mdns_discovery_raw.dart';
import 'package:mdns_platform_check/mdns_platform_check.dart';

enum _MdnsImpl({required final String envValue}) {
  raw(envValue: 'raw'),
  platform(envValue: 'platform');

  // Raw implementation used pure Dart mDNS (multicast_dns) with raw sockets.
  // This approach was unstable on some Windows 10/11 systems due to multicast socket errors.
  //
  // ```console
  // Example failure:
  // [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: OS Error:
  // An unknown, invalid, or unsupported option or level was specified in a getsockopt or setsockopt call, errno = 10042
  // #0      _NativeSocket._nativeJoinMulticast (dart:io-patch/socket_patch.dart:2131)
  // #1      _NativeSocket.joinMulticast (dart:io-patch/socket_patch.dart:2001)
  // #2      _RawDatagramSocket.joinMulticast (dart:io-patch/socket_patch.dart:3044)
  // #3      MDnsClient.start (package:multicast_dns/multicast_dns.dart:158)
  // <asynchronous suspension>
  // ```
  //
  // Due to this platform-specific socket limitation, the implementation was switched
  // to use native platform APIs instead of raw multicast socket handling.
  static _MdnsImpl defaultValue = .platform;
}

Future<_MdnsImpl> _resolveMdnsImpl() async {
  final envVariable = Platform.environment['MDNS_DISCOVERY_IMPL'];
  if (envVariable != null) {
    return .values.firstWhereOrNull((e) => e.envValue == envVariable) ??
        .defaultValue;
  }

  if (!await MdnsPlatformCheck().supportsPlatformApi()) {
    return .raw;
  }
  return .defaultValue;
}

Future<MdnsServiceDiscovery> resolveMdnsServiceDiscoveryImpl() async {
  const serviceType = ProjectConstants.mdnsServiceType;
  final mdnsImpl = await _resolveMdnsImpl();

  return switch (mdnsImpl) {
    .raw => MdnsServiceDiscoveryRaw(
      // Currently, Dart socket implementation don't support reusePort on:
      //
      // - Android: "Dart Socket ERROR: ../../../flutter/third_party/dart/runtime/bin/socket_linux.cc:157: `reusePort` not supported on this platform."
      // - Windows: "Dart Socket ERROR: ../../../flutter/third_party/dart/runtime/bin/socket_win.cc:192: reusePort not supported for Windows.OK"
      //
      // To workaround, it is disabled only on unsupported platforms.
      // https://github.com/flutter/flutter/issues/27346#issuecomment-560931996
      client: MDnsClient(
        rawDatagramSocketFactory: isAndroid || isWindows
            ? (
                host,
                port, {
                bool? reuseAddress,
                bool? reusePort,
                int ttl = 1,
              }) => RawDatagramSocket.bind(
                host,
                port,
                reuseAddress: true,
                reusePort: false,
                ttl: ttl,
              )
            : RawDatagramSocket.bind,
      ),
      serviceType: serviceType,
      logger: Logger('RawMdnsServiceDiscovery'),
    ),
    .platform => MdnsServiceDiscoveryBonsoir(
      discoveryFactory: () => BonsoirDiscovery(type: serviceType),
      logger: Logger('BonsoirMdnsServiceDiscovery'),
    ),
  };
}
