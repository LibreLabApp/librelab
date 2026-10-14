import 'package:librelab_shared/result.dart';

sealed class const JwtValidationFailure(super.message) extends Failure;

/// Token is expired
final class const JwtExpiredFailure() extends JwtValidationFailure {
  this : super('JWT has expired');
}

/// Signature verification failed / token tampered / invalid signature
final class const JwtSignatureVerificationFailure()
    extends JwtValidationFailure {
  this
    : super(
        'JWT signature verification failed (may have been tampered or changed)',
      );
}

/// Token is structurally invalid / cannot be parsed as JWT
final class const JwtParseFailure() extends JwtValidationFailure {
  this : super('JWT is structurally invalid');
}

/// Unknown or unclassified JWT failure
final class const JwtUnknownFailure(String message)
    extends JwtValidationFailure {
  this : super('Unknown, unhandled or unclassified JWT error: $message');
}
