/// API contract versions for client/server compatibility check.
/// Allows gradual upgrades and controlled breaking changes.
///
/// Client sends its [version],
/// server compares it against its own [contractVersion] and
/// [minSupportedContractVersion] to determine compatibility.
///
/// **Note:** API here refers to the shared client-server communication contract,
/// not a generic software API.
abstract final class ApiContractVersionConstants {
  /// Current API contract version shared by client and server.
  //
  // Maintainers: Increment ONLY when both client and server are released together
  // with a breaking or backward-compatible structural API change.
  //
  // Must **NOT** be modified when introducing changes irrelevant to the API
  // (e.g., new decorative animations on client, fixes in CLI arguments parsing on server)
  static const int version = 1;

  /// Minimum supported client contract version.
  /// Used by the server to compare against the client's [version].
  /// Clients below this version are considered incompatible.
  //
  // Maintainers: Increment ONLY when introducing breaking changes
  // that break old clients. Already updated clients should
  // not be required to update again, assuming the breaking change
  // is gradual.
  static const int minSupportedVersion = 1;
}
