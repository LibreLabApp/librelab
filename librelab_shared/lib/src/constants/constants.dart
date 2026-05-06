abstract final class Constants {
  /// The default PostgreSQL database user (superuser).
  ///
  /// This is **only** needed in the scripts/ directory.
  static const String defaultDbUser = 'postgres';

  /// The default PostgreSQL database port.
  ///
  /// This is **only** needed in the scripts/ directory.
  static const int defaultPostgresPort = 5432;

  /// This is **only** needed in the scripts/ directory and the server package.
  static const String forceCreateAdminArgument = '--force-create-admin';

  /// {@template postgres_version_doc}
  /// Used to download the PostgreSQL installer to
  /// automatically install and configure it.
  ///
  /// This is **only** needed on the server package, and specifically
  /// Microsoft Windows, since by default, the package managers install the
  /// available latest version.
  /// {@endtemplate}
  static const String postgresVersion = '18.3-3';

  /// {@macro postgres_version_doc}
  static const String postgresMajorVersion = '18';
}
