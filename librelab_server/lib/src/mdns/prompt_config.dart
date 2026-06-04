import 'dart:io';

import 'package:librelab_server/src/config/app_config/app_config.dart';
import 'package:librelab_server/src/utils/cli_input.dart';
import 'package:librelab_server/src/utils/platform_check.dart';
import 'package:librelab_shared/librelab_shared.dart';

MdnsServicePublishConfig promptMdnsServicePublishConfig() {
  stdout.writeln('''
Local network discovery (mDNS registration & discovery)

This allows other devices on the same local network to automatically detect
and connect to this server without depending on an IP address
that may change over time.

This feature is typically disabled in cloud environments.
''');
  final enable = promptYesNo(
    'Enable local network discovery for this server?',
    defaultValue: !isLikelyHeadlessLinux,
  );
  if (!enable) {
    return const MdnsServicePublishConfig(enabled: false, instanceName: '');
  }

  const instanceNameDefault = ProjectConstants.displayName;
  final instanceName = promptInput(
    'Enter Local network discovery label for this server (has no effect on functionality) [Default: $instanceNameDefault]',
    allowEmpty: true,
  );
  return MdnsServicePublishConfig(
    enabled: enable,
    instanceName: instanceName.isEmpty ? instanceNameDefault : instanceName,
  );
}
