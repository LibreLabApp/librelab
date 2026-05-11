import 'dart:io';

import 'package:librelab_server/src/mdns/mdns_driver.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:librelab_server/src/utils/platform_check.dart';

Future<MdnsDriver> resolveMdnsDriver() async {
  if ((isWindows || isMacOS) &&
      await isCommandAvailable(DnsSdMdnsDriver.command)) {
    return DnsSdMdnsDriver();
  }
  if (isLinux && await isCommandAvailable(AvahiMdnsDriver.command)) {
    return AvahiMdnsDriver();
  }
  stdout.writeln(
    'No system mDNS utility available. Using portable fallback implementation.\n'
    'OS-level .local hostname resolution or local network discovery may not work.',
  );
  return FallbackMdnsDriver();
}
