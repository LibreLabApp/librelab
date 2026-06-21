/// Low-level persistent layer
/// that abstracts platform-specific storage (e.g., dart:io, shared_preferences).
///
/// Does not:
///
/// - perform in-memory caching.
/// - handle serialization/deserialization (e.g., JSON, YAML).
///
/// {@template storage_id}
/// [id] is implementation-defined, e.g., file path in filesystem-based storage
/// or key in shared preferences-based storage.
/// {@endtemplate}
abstract interface class StringStorage {
  /// {@macro storage_id}
  Future<String?> read(String id);

  /// {@macro storage_id}
  Future<void> write(String id, String value);

  /// {@macro storage_id}
  Future<bool> delete(String id);

  /// Returns the resolved storage location for the given id.
  /// The returned value may represent a file path or another backend-specific identifier.
  /// Used for debugging purposes.
  ///
  /// {@macro storage_id}
  String resolvePath(String id, {bool absolute = false});
}
