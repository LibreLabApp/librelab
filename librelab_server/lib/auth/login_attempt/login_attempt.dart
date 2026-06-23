import 'package:meta/meta.dart';

enum LoginResult {
  success,
  invalidCredentials,
  validationError,
  userNotFound,
  locked,
  loginDisabled,
  rateLimited,
}

@immutable
class const LoginAttempt({
  required final int id,
  required final String? userId,
  required final String email,
  required final LoginResult result,
  required final String? ipAddress,
  required final String? userAgent,
  required final DateTime createdAt,
});

@immutable
class const LoginAttemptCreate({
  required final String? userId,
  required final String email,
  required final LoginResult loginResult,
  required final String? ipAddress,
  required final String? userAgent,
});
