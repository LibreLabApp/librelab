// ignore_for_file: annotate_overrides

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_server/database/postgres_constants.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:yaml/yaml.dart';

part 'database_config.dart';
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
  new defaultConfig({
    required int port,
    required MdnsServicePublishConfig mdnsServicePublish,
  }) : this(
         apiServer: .defaultConfig(port: port),
         mdnsServicePublish: mdnsServicePublish,
         database: const .defaultConfig(),
         setupPromptDeclined: const .defaultConfig(),
       );

  factory fromYaml(YamlMap yaml) {
    return .new(
      apiServer: .fromYaml(yaml['apiServer'] as YamlMap),
      mdnsServicePublish: .fromYaml(yaml['mdnsServicePublish'] as YamlMap),
      database: .fromYaml(yaml['database'] as YamlMap),
      setupPromptDeclined: .fromYaml(yaml['setupPromptDeclined'] as YamlMap),
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
