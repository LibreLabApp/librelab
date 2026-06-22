import 'package:librelab_server/auth/login_attempt/login_attempt.dart';

abstract interface class LoginAttemptRepository {
  Future<LoginAttempt> create(LoginAttemptCreate create);

  Future<void> deleteAll();
}
