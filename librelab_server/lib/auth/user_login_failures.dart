import 'package:librelab_shared/result.dart';

sealed class UserLoginFailure extends Failure {
  const UserLoginFailure(super.message);
}

final class UserNotFoundFailure extends UserLoginFailure {
  const UserNotFoundFailure() : super('User not found (by email)');
}

final class InvalidPasswordFailure extends UserLoginFailure {
  const InvalidPasswordFailure() : super('Invalid password');
}

final class InvalidLoginInputFailure extends UserLoginFailure {
  const InvalidLoginInputFailure() : super('Invalid email or password length');
}
