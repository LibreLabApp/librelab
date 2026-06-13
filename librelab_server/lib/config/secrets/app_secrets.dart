import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

@immutable
class AppSecrets {
  const AppSecrets({
    required this.databasePassword,
    required this.jwtAccessTokenSecret,
  });

  factory AppSecrets.fromYaml(YamlMap yaml) => AppSecrets(
    databasePassword: yaml[databasePasswordKey] as String,
    jwtAccessTokenSecret: yaml[jwtAccessTokenSecretKey] as String,
  );

  static const String databasePasswordKey = 'databasePassword';
  final String databasePassword;

  // The jwtAccessTokenSecret is the signing key used to generate and
  // verify JWT access tokens, not an issued token itself.
  static const String jwtAccessTokenSecretKey = 'jwtAccessTokenSecret';
  final String jwtAccessTokenSecret;

  Map<String, Object?> toYaml() => {
    databasePasswordKey: databasePassword,
    jwtAccessTokenSecretKey: jwtAccessTokenSecret,
  };

  AppSecrets copyWith({
    String? databasePassword,
    String? jwtAccessTokenSecret,
  }) {
    return AppSecrets(
      databasePassword: databasePassword ?? this.databasePassword,
      jwtAccessTokenSecret: jwtAccessTokenSecret ?? this.jwtAccessTokenSecret,
    );
  }

  static List<String> get requiredSecretKeys =>
      List.unmodifiable([databasePasswordKey, jwtAccessTokenSecretKey]);
}
