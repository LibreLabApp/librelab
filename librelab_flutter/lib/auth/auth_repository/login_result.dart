import 'package:librelab_api_client/librelab_api_client.dart' show AuthSession;
import 'package:librelab_flutter/auth/auth_repository/login_failures.dart';
import 'package:librelab_flutter/user/models/user.dart';

sealed class const LoginResult();

final class const LoginResultFailure(final LoginFailure failure)
    extends LoginResult;

final class const LoginResultSuccess({
  required final User user,
  required final AuthSession authSession,
}) extends LoginResult;
