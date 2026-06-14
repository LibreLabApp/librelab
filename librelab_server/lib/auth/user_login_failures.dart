import 'package:librelab_shared/result.dart';

sealed class UserLoginFailure extends Failure {
  const UserLoginFailure();
}

final class UserNotFoundFailure extends UserLoginFailure {
  const UserNotFoundFailure();
}

final class InvalidPasswordFailure extends UserLoginFailure {
  const InvalidPasswordFailure();
}

final class InvalidLoginInputFailure extends UserLoginFailure {}
