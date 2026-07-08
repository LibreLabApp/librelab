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
    fullVersion: '16.14-2',
    windowsInstallerSha256:
        '6d3919bc23cfb45e79c6e391de8b689c32101f2c1b73377aa26e4ce593c0ef28',
  ),
  v17(
    majorVersion: 17,
    fullVersion: '17.10-2',
    windowsInstallerSha256:
        '81554536268e499f431efa3fa20736736c64102c719308a03ceb32aa0cb6ae06',
  ),
  v18(
    majorVersion: 18,
    fullVersion: '18.4-2',
    windowsInstallerSha256:
        '0698d1a6083da490e5a57149257f5d9220d8c34109ed11b38aa592d320bf5385',
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
