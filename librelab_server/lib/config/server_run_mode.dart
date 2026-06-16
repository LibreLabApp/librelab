import 'package:librelab_server/utils/is_debug_mode.dart';

enum ServerRunMode {
  production(cliValue: 'production'),
  development(cliValue: 'development'),
  staging(cliValue: 'staging');

  const ServerRunMode({required this.cliValue});

  // Use this instead of .name to prevent unintended breaking changes when renaming
  final String cliValue;

  static ServerRunMode fromCliValue(String? value) {
    if (value == ServerRunMode.development.cliValue) {
      return .development;
    }
    if (value == ServerRunMode.production.cliValue) {
      return .production;
    }
    if (value == ServerRunMode.staging.cliValue) {
      return .staging;
    }
    throw ArgumentError.value(
      value,
      'value',
      'unknown server run mode. allowed values: $values',
    );
  }

  static ServerRunMode get defaultsTo {
    return kDebugMode ? .development : .production;
  }
}
