import 'package:librelab_server/auth/security/jwt/jwt_service.dart';
import 'package:librelab_shared/result.dart';

sealed class AuthenticateFailure extends Failure {
  const AuthenticateFailure(super.message);
}

final class JwtValidationFailureWrapped extends AuthenticateFailure {
  JwtValidationFailureWrapped(this.wrapped) : super(wrapped.message);

  final JwtValidationFailure wrapped;

  @override
  String toString() => wrapped.toString();
}

final class UserDeletedFailure extends AuthenticateFailure {
  const UserDeletedFailure() : super('User not found (may have been deleted)');
}

final class TokenVersionMismatchFailure extends AuthenticateFailure {
  const TokenVersionMismatchFailure()
    : super(
        'The token version in the token does not match the one in database (user may have been revoked it)',
      );
}
