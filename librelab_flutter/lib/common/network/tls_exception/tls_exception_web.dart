import 'package:http/http.dart' as http;

/// Most [http.BaseClient] implementations throw [http.ClientException] on TLS failures.
/// Except `IOClient`, which throws `TlsException` instead.
///
/// However, `TlsException` comes from `dart:io` and cannot be imported on the web.
/// To workaround this, a typedef named [TlsException] declared on the web as
/// [http.ClientException], and as `io.TlsException` on io platforms.
///
/// Consumers of this `TlsException` must handle both [http.ClientException]
/// and [TlsException]:
///
/// ```dart
/// try {
///   /// await ...
/// } on http.ClientException catch (e) {
///   // ...
/// } on TlsException catch (e) {
///   // ...
/// }
/// ```
///
/// This ensures that IO platforms that use `IOClient` handle the correct
/// `io.TlsException`, while web and IO platforms that do not use `IOClient`
/// still work as intended.
typedef TlsException = http.ClientException;
