enum ServerSelectionMethod {
  /// Web only: Uses the server hosting the web application.
  ///
  /// This works when the web application and API are hosted by the same HTTP
  /// server. Otherwise, the server URL must be explicitly provided using
  /// [manual].
  useWebAppServer,

  /// Non-browser clients only: Automatically discovers the server on the local network.
  localNetworkDiscovery,

  /// The user explicitly provides the server URL.
  manual,
}
