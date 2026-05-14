import 'package:flutter/foundation.dart';
import 'package:librelab_shared/librelab_shared.dart';
export 'package:librelab_shared/librelab_shared.dart' show DesktopPlatform;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isWindows =>
    defaultTargetPlatform == TargetPlatform.windows && !kIsWeb;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isLinux => defaultTargetPlatform == TargetPlatform.linux && !kIsWeb;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS && !kIsWeb;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isAndroid =>
    defaultTargetPlatform == TargetPlatform.android && !kIsWeb;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isIos => defaultTargetPlatform == TargetPlatform.iOS && !kIsWeb;

@pragma('vm:platform-const-if', !kDebugMode)
bool get isDesktop =>
    (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows) &&
    !kIsWeb;

DesktopPlatform get currentDesktopPlatform {
  return switch (defaultTargetPlatform) {
    TargetPlatform.linux => DesktopPlatform.linux,
    TargetPlatform.macOS => DesktopPlatform.macOS,
    TargetPlatform.windows => DesktopPlatform.windows,
    _ => throw UnsupportedError(
      'Unsupported platform: ${defaultTargetPlatform.name}',
    ),
  };
}
