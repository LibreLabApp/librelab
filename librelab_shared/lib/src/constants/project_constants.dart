/// Constants that contain values specific to this project.
abstract final class ProjectConstants {
  static const String mdnsServiceType = '_librelab._tcp';

  // TODO: We probably should refactor the configuration generation to be part
  //  of the executable program, and then update the doc comment to say "server only"
  /// This is **only** needed in the scripts/ directory.
  static const int defaultApiPort = 8080;

  /// This is **only** needed in the scripts/ directory.
  static const int defaultInsightsPort = 8081;

  /// The default PostgreSQL database name used by the app.
  ///
  /// This is **only** needed in the scripts/ directory.
  static const String defaultDbName = 'librelab';

  /// The default PostgreSQL username used by the app.
  ///
  /// This is **only** needed in the scripts/ directory.
  static const String defaultUsername = 'librelab';
}
