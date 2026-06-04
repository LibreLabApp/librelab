abstract final class CliOptions {
  static const String helpFlag = 'help';
  static const String forceCreateAdminFlag = 'force-create-admin';
  static const String serverRunModeOption = 'mode';
  static const String applyMigrationsFlag = 'apply-migrations';
}

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
