abstract final class ApiDeployment {
  /// API root path.
  ///
  /// This is **not** part of the API contract. Deployments may expose the API
  /// at a different base URL, for example `https://api.example.org/`
  /// instead of `https://example.org/api`.
  static const String rootPath = '/api';
}
