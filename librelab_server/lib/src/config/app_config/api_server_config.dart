part of 'app_config.dart';

@immutable
class ApiServerConfig {
  const ApiServerConfig({required this.listen, required this.public});

  factory ApiServerConfig.defaultConfig({required int port}) => ApiServerConfig(
    listen: ApiServerListenConfig(port: port, address: '0.0.0.0'),
    public: ApiServerPublicConfig(
      host: 'localhost',
      port: port,
      scheme: 'http',
    ),
  );

  factory ApiServerConfig.fromYaml(YamlMap yaml) {
    return ApiServerConfig(
      listen: ApiServerListenConfig.fromYaml(yaml['listen'] as YamlMap),
      public: ApiServerPublicConfig.fromYaml(yaml['public'] as YamlMap),
    );
  }

  final ApiServerListenConfig listen;
  final ApiServerPublicConfig public;

  Map<String, Object?> toYaml() {
    return {'listen': listen.toYaml(), 'public': public.toYaml()};
  }
}

@immutable
class ApiServerListenConfig {
  const ApiServerListenConfig({required this.port, required this.address});

  factory ApiServerListenConfig.fromYaml(YamlMap yaml) {
    return ApiServerListenConfig(
      port: yaml['port'] as int,
      address: yaml['address'] as String,
    );
  }

  final int port;
  final String address;

  Map<String, Object?> toYaml() {
    return {'port': port, 'address': address};
  }
}

@immutable
class ApiServerPublicConfig {
  const ApiServerPublicConfig({
    required this.host,
    required this.port,
    required this.scheme,
  });

  factory ApiServerPublicConfig.fromYaml(YamlMap yaml) {
    return ApiServerPublicConfig(
      host: yaml['host'] as String,
      port: yaml['port'] as int,
      scheme: yaml['scheme'] as String,
    );
  }

  final String host;
  final int port;
  final String scheme;

  Map<String, Object?> toYaml() {
    return {'host': host, 'port': port, 'scheme': scheme};
  }
}
