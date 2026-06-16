/// The headers that are sent and consumed by the API client and/or API server.
abstract final class ApiHttpHeaders {
  static const String authorization = 'Authorization';
  static const String userAgent = 'User-Agent';

  static const String bearerPrefix = 'Bearer ';
}
