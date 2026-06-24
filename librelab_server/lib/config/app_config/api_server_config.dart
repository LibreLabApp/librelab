part of 'app_config.dart';

@immutable
class const ApiServerConfig({
  required final ApiServerListenConfig listen,
  required final ApiServerPublicConfig public,
}) {
  new defaultConfig({required int port})
    : this(
        listen: ApiServerListenConfig(port: port, address: '0.0.0.0'),
        public: ApiServerPublicConfig(
          host: 'localhost',
          port: port,
          scheme: 'http',
        ),
      );

  factory fromYaml(YamlMap yaml) {
    return ApiServerConfig(
      listen: ApiServerListenConfig.fromYaml(yaml['listen'] as YamlMap),
      public: ApiServerPublicConfig.fromYaml(yaml['public'] as YamlMap),
    );
  }
  Map<String, Object?> toYaml() {
    return {'listen': listen.toYaml(), 'public': public.toYaml()};
  }
}

@immutable
class const ApiServerListenConfig({
  required final int port,
  required final String address,
}) {
  factory fromYaml(YamlMap yaml) {
    return ApiServerListenConfig(
      port: yaml['port'] as int,
      address: yaml['address'] as String,
    );
  }
  Map<String, Object?> toYaml() {
    return {'port': port, 'address': address};
  }
}

@immutable
class const ApiServerPublicConfig({
  required final String host,
  required final int port,
  required final String scheme,
}) {
  factory fromYaml(YamlMap yaml) {
    return ApiServerPublicConfig(
      host: yaml['host'] as String,
      port: yaml['port'] as int,
      scheme: yaml['scheme'] as String,
    );
  }
  Map<String, Object?> toYaml() {
    return {'host': host, 'port': port, 'scheme': scheme};
  }
}
