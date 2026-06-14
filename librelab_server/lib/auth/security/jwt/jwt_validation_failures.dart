import 'package:librelab_shared/result.dart';

sealed class JwtValidationFailure extends Failure {
  const JwtValidationFailure([super.message]);
}

/// Token is expired
final class JwtExpiredFailure extends JwtValidationFailure {
  const JwtExpiredFailure();
}

/// Signature verification failed / token tampered / invalid signature
final class JwtSignatureVerificationFailure extends JwtValidationFailure {
  const JwtSignatureVerificationFailure([super.message]);
}

/// Token is structurally invalid / cannot be parsed as JWT
final class JwtParseFailure extends JwtValidationFailure {
  const JwtParseFailure([super.message]);
}

/// Unknown or unclassified JWT failure
final class JwtUnknownFailure extends JwtValidationFailure {
  const JwtUnknownFailure([super.message]);
}
