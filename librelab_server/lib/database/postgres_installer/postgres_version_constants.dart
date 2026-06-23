enum PostgresVersionInfo({
  required final int majorVersion,

  /// Used to download the installer file on Microsoft Windows only.
  /// Ignored by package managers (apt, dnf, homebrew).
  required final String fullVersion,
}) {
  v16(majorVersion: 16, fullVersion: '16.14-1'),
  v17(majorVersion: 17, fullVersion: '17.10-1'),
  v18(majorVersion: 18, fullVersion: '18.4-2');

  factory fromMajorVersion(int majorVersion) {
    return values.firstWhere(
      (version) => version.majorVersion == majorVersion,
      orElse: () => throw ArgumentError(
        'Unsupported PostgreSQL major version: $majorVersion',
      ),
    );
  }

  /// Note: Version `18.3-3` has an installation issue on some Windows 11 systems:
  ///
  /// ```console
  /// Problem running post-install step. Installation may not complete correctly. The database cluster initialization failed.
  /// ```
  static PostgresVersionInfo recommended = v18;
}
