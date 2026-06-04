import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

@immutable
class AppSecrets {
  const AppSecrets({required this.databasePassword});

  factory AppSecrets.fromYaml(YamlMap yaml) =>
      AppSecrets(databasePassword: yaml[databasePasswordKey] as String);

  Map<String, Object?> toYaml() => {databasePasswordKey: databasePassword};

  static const String databasePasswordKey = 'databasePassword';
  final String databasePassword;

  AppSecrets copyWith({String? databasePassword}) {
    return AppSecrets(
      databasePassword: databasePassword ?? this.databasePassword,
    );
  }

  static List<String> get requiredSecretKeys =>
      List.unmodifiable([databasePasswordKey]);
}
