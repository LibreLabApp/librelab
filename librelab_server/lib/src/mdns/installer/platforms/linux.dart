import 'dart:io';

import 'package:librelab_server/src/mdns/installer/platform_installer.dart';
import 'package:librelab_server/src/mdns/platform/impls/avahi.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:librelab_server/src/utils/linux/linux_package_manager.dart';

final class AvahiLinuxInstaller implements MdnsPlatformInstaller {
  AvahiLinuxInstaller({required LinuxPackageManager packageManager})
    : _packageManager = packageManager;

  final LinuxPackageManager _packageManager;

  static Future<LinuxPackageManager?> systemPackageManager() async {
    for (final packageManager in LinuxPackageManager.values) {
      if (await isCommandAvailable(packageManager.executable)) {
        return packageManager;
      }
    }
    return null;
  }

  @override
  Future<void> install() async {
    switch (_packageManager) {
      case .apt:
        await _installUsingApt();
      case .dnf:
        await _installUsingDnf();
      case .pacman:
        await _installUsingPacman();
    }

    await _maybeConfigureFirewall();

    await _runCommand(
      'sudo',
      ['systemctl', 'enable', '--now', 'avahi-daemon'],
      'start Avahi Daemon now and enable automatic startup on system boot (service)',
    );

    await _runCommand(
      'command',
      ['v', AvahiMdnsRegistrar.command],
      'to double-check whether the required Avahi command is available or not',
    );
  }

  Future<void> _maybeConfigureFirewall() async {
    if (await isCommandAvailable('ufw')) {
      await _runCommand('sudo', [
        'ufw',
        'allow',
        '5353/udp',
        'comment',
        'mDNS service discovery', // Stores the reason inside UFW
      ], 'open UDP port 5353 for local network discovery');
    } else if (await isCommandAvailable('firewall-cmd')) {
      await _runCommand('sudo', [
        'firewall-cmd',
        '--permanent',
        '--add-service=mdns',
      ], 'open UDP port 5353 for local network discovery');
      await _runCommand('sudo', [
        'firewall-cmd',
        '--reload',
      ], 'reload firewalld to apply changes');
    }
  }

  Future<void> _installUsingApt() async {
    await _runCommand(
      'sudo',
      ['apt-get', 'update'],
      'refresh package list from repositories',
      environment: LinuxPackageManager.aptNonInteractiveEnv,
    );

    await _runCommand(
      'sudo',
      [
        'apt-get',
        'install',
        '-y',
        'avahi-daemon',
        'avahi-utils',
        'libnss-mdns',
      ],
      'install Avahi and mDNS hostname resolution support',
      environment: LinuxPackageManager.aptNonInteractiveEnv,
    );
  }

  Future<void> _installUsingDnf() async {
    await _runCommand('sudo', [
      'dnf',
      'install',
      '-y',
      'avahi',
      'avahi-tools',
      'nss-mdns',
    ], 'install Avahi and mDNS hostname resolution support');
  }

  Future<void> _installUsingPacman() async {
    await _runCommand('sudo', [
      'pacman',
      '-S',
      '--noconfirm',
      'avahi',
      'nss-mdns',
    ], 'install Avahi and mDNS hostname resolution support');
  }

  @override
  Future<bool> isInstalled() => isCommandAvailable(AvahiMdnsRegistrar.command);

  @override
  String get promptMessage => '''
Avahi was not detected on this system.

For reliable local network discovery in this server,
we recommend installing it (around 2 MB).

The automated installation installs Avahi, and Multicast DNS (mDNS) NSS plugin (nss-mdns).

It also enables the Avahi Daemon service to start automatically on system boot.

If you have a dedicated firewall (other than ufw or firewalld), 
UDP port 5353 should be opened for mDNS to work correctly.
''';

  Future<Process> _runCommand(
    String executable,
    List<String> args,
    String goal, {
    Map<String, String>? environment,
  }) => executeAndLogCommandOrShutdown(
    executable,
    args,
    goal,
    environment: environment,
  );
}
