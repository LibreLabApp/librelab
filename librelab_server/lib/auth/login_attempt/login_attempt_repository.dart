import 'package:librelab_server/auth/login_attempt/login_attempt.dart';
import 'package:meta/meta.dart';

abstract interface class LoginAttemptRepository {
  Future<LoginAttempt> create(LoginAttemptCreate create);

  Future<void> deleteAll();
}

@immutable
class LoginAttemptCreate {
  const LoginAttemptCreate({
    required this.userId,
    required this.email,
    required this.loginResult,
    required this.ipAddress,
    required this.userAgent,
  });

  final String? userId;
  final String email;
  final LoginResult loginResult;
  final String? ipAddress;
  final String? userAgent;
}
