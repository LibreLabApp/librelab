abstract final class PostgresConstants {
  /// The default PostgreSQL database port.
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
}
