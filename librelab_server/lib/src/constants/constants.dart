abstract final class Constants {
  /// This is **only** needed in the scripts/ directory and the server package.
  static const String forceCreateAdminArgument = '--force-create-admin';
}

abstract final class PostgresConstants {
  /// The default PostgreSQL database port.
  ///
  /// This is **only** needed in the scripts/ directory.
  static const int defaultPort = 5432;

  /// Unix/Linux operating-system user used to execute PostgreSQL commands.
  ///
  /// Example: `sudo -u postgres psql ...`
  static const String defaultOsUser = 'postgres';

  /// PostgreSQL database superuser account.
  ///
  /// Example:
  /// `psql -U postgres ...`
  static const String defaultDbUser = 'postgres';

  /// {@template postgres_version_doc}
  /// Used to download the PostgreSQL installer to
  /// automatically install and configure it.
  ///
  /// This is **only** needed on the server package, and specifically
  /// Microsoft Windows, since by default, the package managers install the
  /// available latest version.
  /// {@endtemplate}
  static const String version = '18.3-3';

  /// {@macro postgres_version_doc}
  static const String majorVersion = '18';
}
