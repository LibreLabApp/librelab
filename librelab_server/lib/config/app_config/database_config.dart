import 'package:librelab_server/database/postgres_constants.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

@immutable
class const DatabaseConfig({
  required final String host,
  required final int port,
  required final String name,
  required final String user,
  required final DatabaseSslMode sslMode,
  required final DatabasePoolConfig pool,
}) {
  const new defaultConfig()
    : this(
        // PostgreSQL install prompt is disabled for remote databases (non-localhost hosts)
        host: 'localhost',
        port: PostgresConstants.defaultPort,
        name: ProjectConstants.defaultDbName,
        user: ProjectConstants.defaultUsername,
        sslMode: .disable,
        pool: const DatabasePoolConfig.defaultConfig(),
      );

  factory fromYaml(YamlMap yaml) {
    return DatabaseConfig(
      host: yaml['host'] as String,
      port: yaml['port'] as int,
      name: yaml['name'] as String,
      user: yaml['user'] as String,
      sslMode: .fromYaml(yaml['sslMode'] as String),
      pool: .fromYaml(yaml['pool'] as YamlMap),
    );
  }
  Map<String, Object?> toYaml() {
    return {
      'host': host,
      'port': port,
      'name': name,
      'user': user,
      'sslMode': sslMode.toYaml(),
      'pool': pool.toYaml(),
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

class const DatabasePoolConfig({required final int maxConnectionCount}) {
  const new defaultConfig() : this(maxConnectionCount: 10);

  factory fromYaml(YamlMap yaml) =>
      .new(maxConnectionCount: yaml['maxConnectionCount'] as int);

  Map<String, Object?> toYaml() {
    return {'maxConnectionCount': maxConnectionCount};
  }
}
