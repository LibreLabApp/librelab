import 'dart:convert';
import 'dart:math';

/// Generates a secure random string of the specified length.
///
/// The [byteLength] parameter specifies the number of random bytes to generate.
/// The result is base64url-encoded without padding.
String generateSecureRandomString([int byteLength = 32]) {
  final random = Random.secure();
  final bytes = List<int>.generate(byteLength, (_) => random.nextInt(256));
  return base64UrlEncode(bytes).replaceAll('=', '');
}

bool isLocalHost(String host) {
  const localHosts = {'localhost', '127.0.0.1', '::1'};
  final normalizedHost = host.trim().toLowerCase();
  return localHosts.contains(normalizedHost);
}
