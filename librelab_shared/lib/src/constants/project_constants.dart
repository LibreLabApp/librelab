/// Constants that contain values specific to this project.
abstract final class ProjectConstants {
  static const String displayName = 'LibreLab';

  static const String mdnsServiceType = '_librelab._tcp';

  /// This is **only** needed in the server.
  static const int defaultApiPort = 8080;

  /// This is **only** needed in the server.
  static const int defaultInsightsPort = 8081;

  /// The default PostgreSQL database name used by the app.
  ///
  /// This is **only** needed in the server.
  static const String defaultDbName = 'librelab';

  /// The default PostgreSQL username used by the app.
  ///
  /// This is **only** needed in the server.
  static const String defaultUsername = 'librelab';
}
