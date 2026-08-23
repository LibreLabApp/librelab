abstract final class CliOptions {
  static const String helpFlag = 'help';
  // TODO: This flag must only create a superuser without starting the server (Connection, not pool),
  //  and maybe it should be an option
  // TODO: Add another option to enable login (important for recovery)
  static const String createSuperUserFlag = 'create-superuser';
  static const String serverRunModeOption = 'mode';
  static const String applyMigrationsFlag = 'apply-migrations';
}
