import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

@immutable
class const HttpServerWebClientHostingConfig({required final bool enabled}) {
  const new defaultConfig({required bool enabled}) : this(enabled: enabled);

  factory fromYaml(YamlMap yaml) {
    return .new(enabled: yaml['enabled'] as bool);
  }
  Map<String, Object?> toYaml() {
    return {'enabled': enabled};
  }
}
