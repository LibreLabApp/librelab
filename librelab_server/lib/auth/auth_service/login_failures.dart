import 'package:librelab_shared/result.dart';

sealed class LoginFailure extends Failure {
  const LoginFailure(super.message);
}

final class UserNotFoundFailure extends LoginFailure {
  const UserNotFoundFailure() : super('User not found (by email)');
}

final class InvalidPasswordFailure extends LoginFailure {
  const InvalidPasswordFailure({required this.targetUserId})
    : super('Invalid password');

  final String targetUserId;
}

final class InvalidLoginInputFailure extends LoginFailure {
  const InvalidLoginInputFailure()
    : super('Invalid email address format or password length');
}

final class LoginDisabledFailure extends LoginFailure {
  const LoginDisabledFailure()
    : super('Login is disabled. Contact system administrator to enable it.');
}
