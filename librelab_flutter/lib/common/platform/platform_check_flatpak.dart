part of 'platform_check.dart';

bool get isFlatpak {
  final env = Platform.environment;
  return env.containsKey('FLATPAK_ID') || env['container'] == 'flatpak';
}
