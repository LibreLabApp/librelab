import 'package:librelab_server/config/app_config/http_server/http_server_api_config.dart';
import 'package:librelab_server/config/app_config/http_server/http_server_web_client_hosting_config.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

@immutable
class const HttpServerConfig({
  required final HttpServerListenConfig listen,
  required final HttpServerPublicConfig public,
  required final HttpServerApiConfig api,
  required final HttpServerWebClientHostingConfig webClientHosting,
}) {
  new defaultConfig({required int port, required bool enableWebClientHosting})
    : this(
        listen: .new(port: port, address: '0.0.0.0'),
        public: .new(host: 'localhost', port: port, scheme: 'http'),
        api: const .defaultConfig(),
        webClientHosting: .defaultConfig(enabled: enableWebClientHosting),
      );

  factory fromYaml(YamlMap yaml) {
    return .new(
      listen: .fromYaml(yaml['listen'] as YamlMap),
      public: .fromYaml(yaml['public'] as YamlMap),
      api: .fromYaml(yaml['api'] as YamlMap),
      webClientHosting: .fromYaml(yaml['webClientHosting'] as YamlMap),
    );
  }
  Map<String, Object?> toYaml() {
    return {
      'listen': listen.toYaml(),
      'public': public.toYaml(),
      'api': api.toYaml(),
      'webClientHosting': webClientHosting.toYaml(),
    };
  }
}

@immutable
class const HttpServerListenConfig({
  required final int port,
  required final String address,
}) {
  factory fromYaml(YamlMap yaml) {
    return .new(port: yaml['port'] as int, address: yaml['address'] as String);
  }
  Map<String, Object?> toYaml() {
    return {'port': port, 'address': address};
  }
}

@immutable
class const HttpServerPublicConfig({
  required final String host,
  required final int port,
  required final String scheme,
}) {
  factory fromYaml(YamlMap yaml) {
    return .new(
      host: yaml['host'] as String,
      port: yaml['port'] as int,
      scheme: yaml['scheme'] as String,
    );
  }
  Map<String, Object?> toYaml() {
    return {'host': host, 'port': port, 'scheme': scheme};
  }
}
