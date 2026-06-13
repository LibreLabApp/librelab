import 'package:bcrypt/bcrypt.dart';
import 'package:librelab_server/auth/security/password_hasher/password_hasher.dart';

class BcryptPasswordHasher implements PasswordHasher {
  @override
  Future<String> hash(String plainPassword) async =>
      BCrypt.hashpw(plainPassword, BCrypt.gensalt());

  @override
  Future<bool> verify({
    required String plainPassword,
    required String passwordHash,
  }) async => BCrypt.checkpw(plainPassword, passwordHash);
}
