import 'dart:convert';
import 'dart:math';

/// Generates a secure random string of the specified length.
///
/// The [byteLength] parameter specifies the number of random bytes to generate.
/// The result is base64url-encoded without padding.
// For consistency with Serverpod, this was copied from: https://github.com/serverpod/serverpod/blob/5affa49285249267d315a6d36148f7608b6eb626/modules/serverpod_auth/serverpod_auth_idp/serverpod_auth_idp_flutter/lib/src/common/utils.dart#L4-L12
String generateSecureRandomString([int byteLength = 24]) {
  final random = Random.secure();
  final bytes = List<int>.generate(byteLength, (i) => random.nextInt(256));
  return base64UrlEncode(bytes).replaceAll('=', '');
}

bool isLocalHost(String host) {
  const localHosts = {'localhost', '127.0.0.1', '::1'};
  final normalizedHost = host.trim().toLowerCase();
  return localHosts.contains(normalizedHost);
}
