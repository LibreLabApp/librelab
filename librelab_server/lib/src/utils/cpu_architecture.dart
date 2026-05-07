import 'dart:io';

import 'package:librelab_server/src/utils/platform_check.dart';

String getPlatformArchitecture() {
  return switch (currentDesktopPlatform) {
    DesktopPlatform.linux => _unix(),
    DesktopPlatform.macOS => _unix(),
    DesktopPlatform.windows =>
      Platform.environment['PROCESSOR_ARCHITECTURE'] ?? 'unknown',
  };
}

bool isWindowsX64() {
  return getPlatformArchitecture().toLowerCase() == 'AMD64'.toLowerCase();
}

String _unix() {
  final result = Process.runSync('uname', ['-m']);
  final arch = (result.stdout as String).trim();

  switch (arch) {
    case 'x86_64':
      return 'x64';
    case 'aarch64':
    case 'arm64':
      return 'arm64';
    case 'armv7l':
      return 'armv7';
    default:
      return arch;
  }
}
