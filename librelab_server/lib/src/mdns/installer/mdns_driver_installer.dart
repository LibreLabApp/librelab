import 'dart:io';

import 'package:librelab_server/src/config/config_files.dart' show ConfigFiles;
import 'package:librelab_server/src/mdns/installer/mdns_platform_installer.dart';
import 'package:librelab_server/src/utils/cli_input.dart';

class MdnsDriverInstaller {
  MdnsDriverInstaller({required MdnsPlatformInstaller platformInstaller})
    : _platformInstaller = platformInstaller;

  final MdnsPlatformInstaller _platformInstaller;

  Future<void> tryInstallWithPrompt({
    required void Function() onDeclined,
  }) async {
    if (await _platformInstaller.isInstalled()) {
      return;
    }

    final userApproved = _prompt();

    if (!userApproved) {
      stdout.writeln(
        '\nmDNS service auto-installer is disabled. This choice will not be prompted again.\n'
        'To change this setting later, edit: ${ConfigFiles.forCurrentRunMode().path}\n'
        'Local devices on this network may not be able to discover and connect\n'
        'to this server properly without manually entering the IP address (should be static).\n',
      );
      onDeclined();
      return;
    }

    await _platformInstaller.install();
  }

  bool _prompt() {
    stdout.writeln('\n${_platformInstaller.promptMessage}');
    return promptYesNo(
      'Proceed with automated mDNS service installation?',
      defaultValue: true,
    );
  }
}
