import 'dart:io';

import 'package:path/path.dart';
import 'package:serverpod/serverpod.dart';

abstract final class ConfigFiles {
  static Directory get _root => Directory('config');

  static File _configFile(String path) => File(join(_root.path, path));

  static File get passwords => _configFile('passwords.yaml');

  static File get production => _configFile('production.yaml');
  static File get development => _configFile('development.yaml');
  static File get staging => _configFile('staging.yaml');

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
