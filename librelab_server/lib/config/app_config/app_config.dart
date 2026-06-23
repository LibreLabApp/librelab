// ignore_for_file: annotate_overrides

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_server/database/postgres_constants.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:yaml/yaml.dart';

part 'api_server_config.dart';
part 'app_config.freezed.dart';

/// Infrastructure configuration (deployment/runtime, not application settings)
@freezed
@immutable
class const AppConfig({
  required final ApiServerConfig apiServer,
  required final MdnsServicePublishConfig mdnsServicePublish,
  required final DatabaseConfig database,
  required final SetupPromptDeclinedConfig setupPromptDeclined,
}) with _$AppConfig {
  factory defaultConfig({
    required int port,
    required MdnsServicePublishConfig mdnsServicePublish,
  }) => AppConfig(
    apiServer: ApiServerConfig.defaultConfig(port: port),
    mdnsServicePublish: mdnsServicePublish,
    database: DatabaseConfig.defaultConfig(),
    setupPromptDeclined: SetupPromptDeclinedConfig.defaultConfig(),
  );

  factory fromYaml(YamlMap yaml) {
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
class const MdnsServicePublishConfig({
  required final bool enabled,
  required final String instanceName,
}) {
  factory fromYaml(YamlMap yaml) {
    return MdnsServicePublishConfig(
      enabled: yaml['enabled'] as bool,
      instanceName: yaml['instanceName'] as String,
    );
  }
  Map<String, Object?> toYaml() {
    return {'enabled': enabled, 'instanceName': instanceName};
  }
}

@immutable
class const DatabaseConfig({
  required final String host,
  required final int port,
  required final String name,
  required final String user,
  required final DatabaseSslMode sslMode,
}) {
  factory defaultConfig() => const DatabaseConfig(
    // PostgreSQL install prompt is disabled for remote databases (non-localhost hosts)
    host: 'localhost',
    port: PostgresConstants.defaultPort,
    name: ProjectConstants.defaultDbName,
    user: ProjectConstants.defaultUsername,
    sslMode: .disable,
  );

  factory fromYaml(YamlMap yaml) {
    return DatabaseConfig(
      host: yaml['host'] as String,
      port: yaml['port'] as int,
      name: yaml['name'] as String,
      user: yaml['user'] as String,
      sslMode: DatabaseSslMode.fromYaml(yaml['sslMode'] as String),
    );
  }
  Map<String, Object?> toYaml() {
    return {
      'host': host,
      'port': port,
      'name': name,
      'user': user,
      'sslMode': sslMode.toYaml(),
    };
  }
}

enum DatabaseSslMode {
  disable,
  require,
  verifyFull;

  factory fromYaml(String value) => switch (value) {
    'disable' => .disable,
    'require' => .require,
    'verifyFull' => .verifyFull,
    String() => throw UnsupportedError('Unsupported database SSL mode: $value'),
  };

  String toYaml() => switch (this) {
    .disable => 'disable',
    .require => 'require',
    .verifyFull => 'verifyFull',
  };
}

@freezed
@immutable
class const SetupPromptDeclinedConfig({
  required final bool postgres,
  required final bool systemMdnsService,
}) with _$SetupPromptDeclinedConfig {
  factory defaultConfig() => const SetupPromptDeclinedConfig(
    postgres: false,
    systemMdnsService: false,
  );

  factory fromYaml(YamlMap yaml) {
    return SetupPromptDeclinedConfig(
      postgres: yaml['postgres'] as bool,
      systemMdnsService: yaml['systemMdnsService'] as bool,
    );
  }
  Map<String, Object?> toYaml() {
    return {'postgres': postgres, 'systemMdnsService': systemMdnsService};
  }
}
