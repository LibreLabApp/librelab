import 'package:librelab_server/auth/security/jwt/jwt_service.dart';
import 'package:librelab_shared/result.dart';

sealed class AuthenticateFailure extends Failure {
  const AuthenticateFailure();
}

final class JwtAuthenticationFailure extends AuthenticateFailure {
  const JwtAuthenticationFailure(this.failure);

  final JwtValidationFailure failure;
}

final class UserDeletedFailure extends AuthenticateFailure {
  const UserDeletedFailure();
}

final class TokenVersionMismatchFailure extends AuthenticateFailure {
  const TokenVersionMismatchFailure();
}
