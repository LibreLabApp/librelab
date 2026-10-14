import 'package:librelab_shared/result.dart';

sealed class const LoginFailure(super.message) extends Failure;

final class const UserNotFoundFailure() extends LoginFailure {
  this : super('User not found (by email)');
}

final class const InvalidPasswordFailure({required final String targetUserId})
    extends LoginFailure {
  this : super('Invalid password');
}

final class const InvalidLoginInputFailure() extends LoginFailure {
  this : super('Invalid email address format or password length');
}

final class const LoginDisabledFailure() extends LoginFailure {
  this : super('Login is disabled. Contact system administrator to enable it.');
}
