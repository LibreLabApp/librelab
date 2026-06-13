abstract interface class PasswordHasher {
  Future<String> hash(String plainPassword);

  Future<bool> verify({
    required String plainPassword,
    required String passwordHash,
  });
}
