import 'package:librelab_flutter/auth/auth_repository/login_failures.dart';
import 'package:librelab_flutter/auth/login_identity/models/login_identity.dart';
import 'package:librelab_flutter/user/models/user.dart';

sealed class const LoginResult();

final class LoginResultFailure extends LoginResult {
  const new(this.failure);

  final LoginFailure failure;
}

sealed class LoginResultSuccess extends LoginResult {
  const new(this.user);

  final User user;
}

final class LoginSuccessWithTokens extends LoginResultSuccess {
  const new(
    super.user, {
    required this.accessToken,
    required this.refreshToken,
  });

  final AuthToken accessToken;
  final AuthToken refreshToken;
}

final class LoginSuccessWithoutTokens extends LoginResultSuccess {
  const new(super.user);
}
