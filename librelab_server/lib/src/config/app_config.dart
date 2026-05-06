import 'package:serverpod/serverpod.dart';
import 'package:yaml/yaml.dart';

// Currently, Serverpod does not support custom configurations inside config/<runMode>.yaml file
// https://github.com/serverpod/serverpod/issues/633
// A workaround is to store and parse them manually.

@immutable
class AppConfig {
  const AppConfig({required this.mdns, required this.postgresInstallDeclined});

  factory AppConfig.defaultConfig({required MdnsConfig mdns}) =>
      AppConfig(mdns: mdns, postgresInstallDeclined: false);

  factory AppConfig.fromYaml(YamlMap yaml) {
    return AppConfig(
      mdns: MdnsConfig.fromYaml(yaml['mdns'] as YamlMap),
      postgresInstallDeclined:
          yaml['postgresInstallDeclined'] as bool? ?? false,
    );
  }

  Map<String, Object?> toYaml() {
    return {
      'mdns': mdns.toYaml(),
      'postgresInstallDeclined': postgresInstallDeclined,
    };
  }

  final MdnsConfig mdns;
  final bool postgresInstallDeclined;

  AppConfig copyWith({MdnsConfig? mdns, bool? postgresInstallDeclined}) {
    return AppConfig(
      mdns: mdns ?? this.mdns,
      postgresInstallDeclined:
          postgresInstallDeclined ?? this.postgresInstallDeclined,
    );
  }
}

@immutable
class MdnsConfig {
  const MdnsConfig({required this.advertise, required this.instanceName});

  factory MdnsConfig.fromYaml(YamlMap yaml) {
    return MdnsConfig(
      advertise: yaml['advertise'] as bool,
      instanceName: yaml['instanceName'] as String,
    );
  }

  Map<String, Object?> toYaml() {
    return {'advertise': advertise, 'instanceName': instanceName};
  }

  final bool advertise;
  final String instanceName;
}
