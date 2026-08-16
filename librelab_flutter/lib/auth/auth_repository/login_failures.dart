import 'package:librelab_shared/result.dart';

sealed class LoginFailure extends Failure {
  const new(super.message);
}

final class InvalidLoginCredentialsFailure extends LoginFailure {
  const new() : super('Invalid email or password.');
}

final class LoginDisabledFailure extends LoginFailure {
  const new()
    : super('Login is disabled. Contact an administrator to enable it.');
}

final class InvalidLoginInputFailure extends LoginFailure {
  const new()
    : super(
        'The login input (email and/or password) does not meet the required format or length constraints.',
      );
}
