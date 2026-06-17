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
class LoginAttempt {
  const LoginAttempt({
    required this.id,
    required this.userId,
    required this.email,
    required this.result,
    required this.ipAddress,
    required this.userAgent,
    required this.createdAt,
  });

  final int id;
  final String? userId;
  final String email;
  final LoginResult result;
  final String? ipAddress;
  final String? userAgent;
  final DateTime createdAt;
}
