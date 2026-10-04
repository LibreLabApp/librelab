import 'package:http_status_code_enum/http_status_code_enum.dart';

abstract final class AuthHttpStatusCodes {
  /// Keep 401 as the HTTP status for unauthenticated responses.
  ///
  /// This is part of the authentication contract because the
  /// `NetworkImageLoadException` thrown by Flutter's `NetworkImage` does not
  /// provide the response body, so image requests rely on 401 to
  /// detect an expired token and trigger authentication refresh handling.
  /// Changing this status can break authentication handling for image
  /// requests.
  ///
  /// See also: https://api.flutter.dev/flutter/painting/NetworkImageLoadException-class.html
  ///
  /// Note: Flutter's `NetworkImage` is currently not used for authenticated
  /// image requests, but this status remains part of the API contract in case
  /// it is used in the future. Changing it could introduce a breaking change.
  static const HttpStatusCode unauthorized = .unauthorized;
}
