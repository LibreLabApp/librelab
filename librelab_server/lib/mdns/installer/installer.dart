import 'dart:io';

import 'package:librelab_server/mdns/installer/platform_installer.dart';
import 'package:librelab_server/utils/cli_input.dart';

class MdnsInstaller {
  MdnsInstaller({required this._platform, required this._getConfigFilePath});

  final MdnsPlatformInstaller _platform;
  final String Function() _getConfigFilePath;

  Future<void> tryInstallWithPrompt({
    required void Function() onDeclined,
  }) async {
    if (await _platform.isInstalled()) {
      return;
    }

    final userApproved = _prompt();

    if (!userApproved) {
      stdout.writeln(
        '\nmDNS service auto-installer is disabled. This choice will not be prompted again.\n'
        'IMPORTANT: Local devices on this network may not be able to discover and connect\n'
        'to this server.\n'
        'Clients can still connect using a manually entered IP address (must be STATIC or reserved).\n'
        'To change this setting later, edit: ${_getConfigFilePath()}\n',
      );
      onDeclined();
      return;
    }

    await _platform.install();
  }

  bool _prompt() {
    stdout.writeln('\n${_platform.promptMessage}');
    return promptYesNo(
      'Proceed with automated mDNS service installation?',
      defaultValue: true,
    );
  }
}
