import 'dart:io';

import 'package:librelab_server/src/utils/platform_check.dart';

String getRawPlatformArchitecture() =>
    _getPlatformArchitecture(normalized: false);

String getNormalizedPlatformArchitecture() =>
    _getPlatformArchitecture(normalized: true);

String _getPlatformArchitecture({required bool normalized}) {
  return switch (currentDesktopPlatform) {
    DesktopPlatform.linux => _unix(normalized: normalized),
    DesktopPlatform.macOS => _unix(normalized: normalized),
    DesktopPlatform.windows => _windows(normalized: normalized),
  };
}

String _windows({required bool normalized}) {
  final processorArchitecture = Platform.environment['PROCESSOR_ARCHITECTURE'];

  if (normalized && processorArchitecture == 'AMD64') {
    return 'x64';
  }

  return processorArchitecture ?? 'unknown';
}

bool isWindowsX64() {
  return getRawPlatformArchitecture().toLowerCase() == 'AMD64'.toLowerCase();
}

String _unix({required bool normalized}) {
  final result = Process.runSync('uname', ['-m']);
  final String? output = result.stdout?.toString();

  if (result.exitCode != 0 || output == null) {
    throw StateError('Failed to detect CPU architecture via "uname -m"');
  }

  final arch = output.trim();

  if (!normalized) {
    return arch;
  }

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
