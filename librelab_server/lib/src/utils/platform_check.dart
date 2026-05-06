import 'dart:io';

import 'package:librelab_shared/librelab_shared.dart';
export 'package:librelab_shared/librelab_shared.dart' show DesktopPlatform;

@pragma('vm:platform-const')
bool get isWindows => Platform.isWindows;

@pragma('vm:platform-const')
bool get isLinux => Platform.isLinux;

@pragma('vm:platform-const')
bool get isMacOS => Platform.isMacOS;

bool get isUnixLike => isLinux || isMacOS;

DesktopPlatform get currentDesktopPlatform {
  if (isWindows) {
    return .windows;
  } else if (isLinux) {
    return .linux;
  } else if (isMacOS) {
    return .macOS;
  }
  throw UnsupportedError('Unsupported OS: ${Platform.operatingSystem}');
}

bool get isLikelyHeadlessLinux {
  final env = Platform.environment;
  return isLinux &&
      !env.containsKey('DISPLAY') &&
      !env.containsKey('WAYLAND_DISPLAY');
}
