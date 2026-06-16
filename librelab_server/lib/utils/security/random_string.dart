import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

final _secureRandom = Random.secure();

/// Generates a secure random string of the specified length.
///
/// The [byteLength] parameter specifies the number of random bytes to generate.
/// The result is base64url-encoded without padding.
String generateSecureRandomString([int byteLength = 32]) {
  final bytes = Uint8List(byteLength);
  final random = _secureRandom;

  for (int i = 0; i < byteLength; i++) {
    bytes[i] = random.nextInt(256);
  }

  return base64UrlEncode(bytes).replaceAll('=', '');
}
