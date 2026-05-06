import 'dart:io';

import 'package:path/path.dart';
import 'package:serverpod/serverpod.dart';

abstract final class ConfigFileNames {
  static const String configRoot = 'config';

  static const String passwords = 'passwords.yaml';
  static const String production = 'production.yaml';
  static const String development = 'development.yaml';
  static const String staging = 'development.yaml';
}

abstract final class ConfigFiles {
  static Directory get configRoot => Directory(ConfigFileNames.configRoot);

  static File _configFile(String path) => File(join(configRoot.path, path));

  static File get passwords => _configFile(ConfigFileNames.passwords);
  static File get production => _configFile(ConfigFileNames.production);
  static File get development => _configFile(ConfigFileNames.development);
  static File get staging => _configFile(ConfigFileNames.staging);

  static File forRunMode(String runMode) {
    return switch (runMode) {
      ServerpodRunMode.production => production,
      ServerpodRunMode.development => development,
      ServerpodRunMode.staging => staging,
      String() => throw ArgumentError.value(
        runMode,
        'runMode',
        'runMode must be production, development or staging.',
      ),
    };
  }

  static File forCurrentRunMode() => forRunMode(Serverpod.instance.runMode);
}
