import 'package:librelab_server/auth/security/jwt/jwt_service.dart';
import 'package:librelab_shared/result.dart';

sealed class const AuthenticateFailure(super.message) extends Failure;

final class JwtValidationFailureWrapped extends AuthenticateFailure {
  new(this.wrapped) : super(wrapped.message);

  final JwtValidationFailure wrapped;

  @override
  String toString() => wrapped.toString();
}

final class const UserDeletedFailure() extends AuthenticateFailure {
  this : super('User not found (may have been deleted)');
}

final class const TokenVersionMismatchFailure() extends AuthenticateFailure {
  this
    : super(
        'The token version in the token does not match the one in database (user may have been revoked it)',
      );
}
