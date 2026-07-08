// ignore_for_file: annotate_overrides

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_server/config/app_config/database_config.dart';
import 'package:librelab_server/config/app_config/http_server/http_server_config.dart';
import 'package:yaml/yaml.dart';

part 'app_config.freezed.dart';

/// Infrastructure configuration (deployment/runtime, not application settings)
@freezed
@immutable
class const AppConfig({
  required final HttpServerConfig httpServer,
  required final MdnsServicePublishConfig mdnsServicePublish,
  required final DatabaseConfig database,
  required final SetupPromptDeclinedConfig setupPromptDeclined,
}) with _$AppConfig {
  new defaultConfig({
    required int port,
    required MdnsServicePublishConfig mdnsServicePublish,
    required bool enableWebClientHosting,
  }) : this(
         httpServer: .defaultConfig(
           port: port,
           enableWebClientHosting: enableWebClientHosting,
         ),
         mdnsServicePublish: mdnsServicePublish,
         database: const .defaultConfig(),
         setupPromptDeclined: const .defaultConfig(),
       );

  factory fromYaml(YamlMap yaml) {
    return .new(
      httpServer: .fromYaml(yaml['httpServer'] as YamlMap),
      mdnsServicePublish: .fromYaml(yaml['mdnsServicePublish'] as YamlMap),
      database: .fromYaml(yaml['database'] as YamlMap),
      setupPromptDeclined: .fromYaml(yaml['setupPromptDeclined'] as YamlMap),
    );
  }
  Map<String, Object?> toYaml() {
    return {
      'httpServer': httpServer.toYaml(),
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
    return .new(
      enabled: yaml['enabled'] as bool,
      instanceName: yaml['instanceName'] as String,
    );
  }
  Map<String, Object?> toYaml() {
    return {'enabled': enabled, 'instanceName': instanceName};
  }
}

@freezed
@immutable
class const SetupPromptDeclinedConfig({
  required final bool postgres,
  required final bool systemMdnsService,
}) with _$SetupPromptDeclinedConfig {
  const new defaultConfig() : this(postgres: false, systemMdnsService: false);

  factory fromYaml(YamlMap yaml) {
    return .new(
      postgres: yaml['postgres'] as bool,
      systemMdnsService: yaml['systemMdnsService'] as bool,
    );
  }
  Map<String, Object?> toYaml() {
    return {'postgres': postgres, 'systemMdnsService': systemMdnsService};
  }
}
