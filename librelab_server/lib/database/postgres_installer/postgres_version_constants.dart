enum PostgresVersionInfo({
  required final int majorVersion,

  /// Used to download the installer file on Microsoft Windows only.
  /// Ignored by package managers (apt, dnf, homebrew).
  required final String fullVersion,

  /// SHA-256 checksum of the Windows installer file.
  /// Ignored on other platforms.
  required final String windowsInstallerSha256,
}) {
  v16(
    majorVersion: 16,
    fullVersion: '16.15-1',
    windowsInstallerSha256:
        'de926fefad00e313e212cd438c0f04bf033e200099ad56c012724efcebed79f2',
  ),
  v17(
    majorVersion: 17,
    fullVersion: '17.11-1',
    windowsInstallerSha256:
        'f104c552d8495a6f20738c2a03f643164bc64b9985363329e314dec24559f0b7',
  ),
  v18(
    majorVersion: 18,
    fullVersion: '18.6-1',
    windowsInstallerSha256:
        'cae561e98d09f3f4a1a95759249240f86f66d71dcf33d14b6f7be894078401d1',
  );

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
