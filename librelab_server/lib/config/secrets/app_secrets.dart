import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

@immutable
class const AppSecrets({
  required final String databasePassword,
  required final String jwtAccessTokenSecret,
}) {
  factory fromYaml(YamlMap yaml) => AppSecrets(
    databasePassword: yaml[databasePasswordKey] as String,
    jwtAccessTokenSecret: yaml[jwtAccessTokenSecretKey] as String,
  );

  static const String databasePasswordKey = 'databasePassword';

  /// The [jwtAccessTokenSecret] is the signing key used to generate and
  /// verify JWT access tokens, not an issued token itself.
  static const String jwtAccessTokenSecretKey = 'jwtAccessTokenSecret';

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
      .unmodifiableOf([databasePasswordKey, jwtAccessTokenSecretKey]);
}
