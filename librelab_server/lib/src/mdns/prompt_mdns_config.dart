import 'dart:io';

import 'package:librelab_server/src/config/app_config.dart';
import 'package:librelab_server/src/utils/cli_input.dart';
import 'package:librelab_server/src/utils/platform_check.dart';
import 'package:librelab_shared/librelab_shared.dart';

MdnsConfig promptMdnsConfig() {
  stdout.writeln('''
\nLocal network discovery (mDNS advertising)

Allows other devices on the same network to automatically detect this server,
instead of manually entering an IP address that may change over time.

Use it when:
- Running in a home or office network
- Local devices need automatic access

Avoid it when:
- Running in public or cloud environments
- You want to prevent service discovery on the network
''');
  final advertise = promptYesNo(
    'Enable local network discovery for this server?',
    defaultValue: !isLikelyHeadlessLinux,
  );
  if (!advertise) {
    return const MdnsConfig(advertise: false, instanceName: '');
  }

  const instanceNameDefault = ProjectConstants.displayName;
  final instanceName = promptInput(
    'Enter mDNS instance name (used for local network label only, has no effect on functionality) [Default: $instanceNameDefault]',
    allowEmpty: true,
  );
  return MdnsConfig(
    advertise: advertise,
    instanceName: instanceName.isEmpty ? instanceNameDefault : instanceName,
  );
}
