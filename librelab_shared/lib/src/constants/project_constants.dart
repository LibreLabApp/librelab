/// Constants that contain values specific to this project.
abstract final class ProjectConstants {
  static const String _repo = 'https://github.com/LibreLabApp/librelab';

  // (LATER) TODO: Replace the placeholder link once we have a website
  static const String hostServerGuideLink =
      '$_repo/guides/how-to-host-a-server.md';

  static const String displayName = 'LibreLab';

  // Hardcoded in Info.plist (macOS and iOS platform runners)
  static const String mdnsServiceType = '_librelab._tcp';

  /// This is **only** needed in the server.
  static const int defaultApiPort = 45123;

  /// This is **only** needed in the server.
  static const int defaultInsightsPort = 45124;

  /// The default PostgreSQL database name used by the app.
  ///
  /// This is **only** needed in the server.
  static const String defaultDbName = 'librelab';

  /// The default PostgreSQL username used by the app.
  ///
  /// This is **only** needed in the server.
  static const String defaultUsername = 'librelab';
}
