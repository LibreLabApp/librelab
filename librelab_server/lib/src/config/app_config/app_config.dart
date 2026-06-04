import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_server/src/constants/constants.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:yaml/yaml.dart';

part 'api_server_config.dart';
part 'app_config.freezed.dart';

@freezed
@immutable
class AppConfig with _$AppConfig {
  const AppConfig({
    required this.apiServer,
    required this.mdnsServicePublish,
    required this.database,
    required this.setupPromptDeclined,
  });

  factory AppConfig.defaultConfig({
    required int port,
    required MdnsServicePublishConfig mdnsServicePublish,
  }) => AppConfig(
    apiServer: ApiServerConfig.defaultConfig(port: port),
    mdnsServicePublish: mdnsServicePublish,
    database: DatabaseConfig.defaultConfig(),
    setupPromptDeclined: SetupPromptDeclinedConfig.defaultConfig(),
  );

  factory AppConfig.fromYaml(YamlMap yaml) {
    return AppConfig(
      apiServer: ApiServerConfig.fromYaml(yaml['apiServer'] as YamlMap),
      mdnsServicePublish: MdnsServicePublishConfig.fromYaml(
        yaml['mdnsServicePublish'] as YamlMap,
      ),
      database: DatabaseConfig.fromYaml(yaml['database'] as YamlMap),
      setupPromptDeclined: SetupPromptDeclinedConfig.fromYaml(
        yaml['setupPromptDeclined'] as YamlMap,
      ),
    );
  }

  @override
  final ApiServerConfig apiServer;

  @override
  final MdnsServicePublishConfig mdnsServicePublish;

  @override
  final DatabaseConfig database;

  @override
  final SetupPromptDeclinedConfig setupPromptDeclined;

  Map<String, Object?> toYaml() {
    return {
      'apiServer': apiServer.toYaml(),
      'mdnsServicePublish': mdnsServicePublish.toYaml(),
      'database': database.toYaml(),
      'setupPromptDeclined': setupPromptDeclined.toYaml(),
    };
  }
}

@immutable
class MdnsServicePublishConfig {
  const MdnsServicePublishConfig({
    required this.enabled,
    required this.instanceName,
  });

  factory MdnsServicePublishConfig.fromYaml(YamlMap yaml) {
    return MdnsServicePublishConfig(
      enabled: yaml['enabled'] as bool,
      instanceName: yaml['instanceName'] as String,
    );
  }

  final bool enabled;
  final String instanceName;

  Map<String, Object?> toYaml() {
    return {'enabled': enabled, 'instanceName': instanceName};
  }
}

@immutable
class DatabaseConfig {
  const DatabaseConfig({
    required this.host,
    required this.port,
    required this.name,
    required this.user,
  });

  factory DatabaseConfig.fromYaml(YamlMap yaml) {
    return DatabaseConfig(
      host: yaml['host'] as String,
      port: yaml['port'] as int,
      name: yaml['name'] as String,
      user: yaml['user'] as String,
    );
  }

  factory DatabaseConfig.defaultConfig() => const DatabaseConfig(
    // PostgreSQL install prompt is disabled for remote databases (non-localhost hosts)
    host: 'localhost',
    port: PostgresConstants.defaultPort,
    name: ProjectConstants.defaultDbName,
    user: ProjectConstants.defaultUsername,
  );

  final String host;
  final int port;
  final String name;
  final String user;

  Map<String, Object?> toYaml() {
    return {'host': host, 'port': port, 'name': name, 'user': user};
  }
}

@freezed
@immutable
class SetupPromptDeclinedConfig with _$SetupPromptDeclinedConfig {
  const SetupPromptDeclinedConfig({
    required this.postgres,
    required this.systemMdnsService,
  });

  factory SetupPromptDeclinedConfig.fromYaml(YamlMap yaml) {
    return SetupPromptDeclinedConfig(
      postgres: yaml['postgres'] as bool,
      systemMdnsService: yaml['systemMdnsService'] as bool,
    );
  }

  factory SetupPromptDeclinedConfig.defaultConfig() =>
      const SetupPromptDeclinedConfig(
        postgres: false,
        systemMdnsService: false,
      );

  @override
  final bool postgres;
  @override
  final bool systemMdnsService;

  Map<String, Object?> toYaml() {
    return {'postgres': postgres, 'systemMdnsService': systemMdnsService};
  }
}
