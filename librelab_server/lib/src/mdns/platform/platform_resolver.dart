import 'dart:io';

import 'package:librelab_server/src/mdns/platform/impls/avahi.dart';
import 'package:librelab_server/src/mdns/platform/impls/dns_sd.dart';
import 'package:librelab_server/src/mdns/platform/impls/fallback.dart';
import 'package:librelab_server/src/mdns/platform/platform_registrar.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:librelab_server/src/utils/platform_check.dart';

Future<MdnsPlatformRegistrar> resolveMdnsPlatformRegistrar() async {
  if ((isWindows || isMacOS) &&
      await isCommandAvailable(DnsSdMdnsRegistrar.command)) {
    return DnsSdMdnsRegistrar();
  }
  if (isLinux && await isCommandAvailable(AvahiMdnsRegistrar.command)) {
    return AvahiMdnsRegistrar();
  }
  stdout.writeln(
    'No system mDNS utility available. Using portable fallback implementation.\n'
    'OS-level .local hostname resolution or local network discovery may not work.',
  );
  return FallbackMdnsRegistrar();
}
