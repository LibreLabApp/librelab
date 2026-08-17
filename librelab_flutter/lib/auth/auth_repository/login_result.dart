import 'package:librelab_api_client/librelab_api_client.dart' show AuthSession;
import 'package:librelab_flutter/auth/auth_repository/login_failures.dart';
import 'package:librelab_flutter/user/models/user.dart';

sealed class const LoginResult();

final class LoginResultFailure extends LoginResult {
  const new(this.failure);

  final LoginFailure failure;
}

final class LoginResultSuccess extends LoginResult {
  const new({required this.user, required this.session});

  final User user;
  final AuthSession session;
}
