import 'dart:io';

import 'package:librelab_server/src/config/app_config.dart';
import 'package:librelab_server/src/utils/cli_input.dart';
import 'package:librelab_server/src/utils/platform_check.dart';
import 'package:librelab_shared/librelab_shared.dart';

MdnsConfig promptMdnsConfig() {
  stdout.writeln('''
\nEnable local network discovery (mDNS)?

This allows devices on your network to find this server automatically, 
avoiding the need to manually type an IP address that might change.

Recommended if:
- Running on a home or office network.
- Other local devices need easy access.

Disable if:
- Running in a public or cloud environment.
- You want to keep the server hidden from discovery.
''');
  final advertise = promptYesNo(
    'Enable mDNS advertising?',
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
