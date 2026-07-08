import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

@immutable
class const HttpServerApiConfig({required final CookiesConfig cookies}) {
  const new defaultConfig() : this(cookies: const .defaultConfig());

  factory fromYaml(YamlMap yaml) {
    return .new(cookies: .fromYaml(yaml['cookies'] as YamlMap));
  }
  Map<String, Object?> toYaml() {
    return {'cookies': cookies.toYaml()};
  }
}

@immutable
class const CookiesConfig({required final bool secure}) {
  const new defaultConfig() : this(secure: false);

  factory fromYaml(YamlMap yaml) {
    return .new(secure: yaml['secure'] as bool);
  }
  Map<String, Object?> toYaml() {
    return {'secure': secure};
  }
}
