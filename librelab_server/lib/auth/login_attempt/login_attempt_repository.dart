import 'package:librelab_server/auth/login_attempt/login_attempt.dart';

abstract interface class LoginAttemptRepository {
  Future<LoginAttempt> create({
    required String? userId,
    required String email,
    required LoginResult loginResult,
    required String? ipAddress,
    required String? userAgent,
  });

  Future<void> deleteAll();
}
