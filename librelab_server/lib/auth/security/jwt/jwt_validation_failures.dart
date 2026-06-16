import 'package:librelab_shared/result.dart';

sealed class JwtValidationFailure extends Failure {
  const JwtValidationFailure(super.message);
}

/// Token is expired
final class JwtExpiredFailure extends JwtValidationFailure {
  const JwtExpiredFailure() : super('JWT has expired');
}

/// Signature verification failed / token tampered / invalid signature
final class JwtSignatureVerificationFailure extends JwtValidationFailure {
  const JwtSignatureVerificationFailure()
    : super(
        'JWT signature verification failed (may have been tampered or changed)',
      );
}

/// Token is structurally invalid / cannot be parsed as JWT
final class JwtParseFailure extends JwtValidationFailure {
  const JwtParseFailure() : super('JWT is structurally invalid');
}

/// Unknown or unclassified JWT failure
final class JwtUnknownFailure extends JwtValidationFailure {
  const JwtUnknownFailure(String message)
    : super('Unknown, unhandled or unclassified JWT error: $message');
}
