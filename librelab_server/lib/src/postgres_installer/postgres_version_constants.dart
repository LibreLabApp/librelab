import 'package:librelab_server/src/utils/platform_check.dart';

enum PostgresVersionInfo {
  v16(majorVersion: '16', fullVersion: '16.14-1'),
  v17(majorVersion: '17', fullVersion: '17.10-1'),
  v18(majorVersion: '18', fullVersion: '18.4-1');

  const PostgresVersionInfo({
    required this.majorVersion,
    required this.fullVersion,
  });

  final String majorVersion;

  /// Used to download the installer file on Microsoft Windows only.
  /// Ignored by package managers (apt, dnf, homebrew).
  final String fullVersion;

  /// The default version is 17.9-3 and not 18.3-3 to workaround
  /// an issue on some Windows systems:
  ///
  /// ```console
  /// Problem running post-install step. Installation may not complete correctly. The database cluster initialization failed.
  /// ```
  static PostgresVersionInfo recommended = isWindows ? v17 : v18;

  static PostgresVersionInfo fromMajorVersion(String majorVersion) {
    return values.firstWhere(
      (version) => version.majorVersion == majorVersion,
      orElse: () => throw ArgumentError(
        'Unsupported PostgreSQL major version: $majorVersion',
      ),
    );
  }
}
