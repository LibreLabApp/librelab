abstract interface class StringStorage {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<bool> delete(String key);
}
