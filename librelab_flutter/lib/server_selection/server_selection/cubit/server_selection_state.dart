// ignore_for_file: annotate_overrides

part of 'server_selection_cubit.dart';

@freezed
@immutable
class const ServerSelectionState({
  /// Must not use [ServerSelectionMethod.localNetworkDiscovery] on web
  /// (due to lack of native mDNS service discovery support).
  required final ServerSelectionMethod selectionMethod,

  /// Should be only used if [selectionMethod] is [ServerSelectionMethod.manual].
  required final String? manualServerAddress,

  required final LocalDiscoveryState discoveryState,
  required final ServerCompatibilityCheckState compatibilityCheckState,
}) with _$ServerSelectionState {
  const new initial()
    : this(
        selectionMethod: kIsWeb ? .useWebAppServer : .localNetworkDiscovery,
        manualServerAddress: null,
        discoveryState: const .initial(),
        compatibilityCheckState: const .initial(),
      );

  /// Returns the URI from the successful compatibility check for [selectedServer].
  ///
  /// Throws a [StateError] if the compatibility check has not succeeded or its
  /// result does not correspond to [selectedServer].
  Uri serverUriOrThrow() {
    final state = compatibilityCheckState;
    if (state is! Success) {
      throw StateError('Compatibility check state must be successful');
    }

    if (state.server != selectedServer) {
      throw StateError(
        'Compatibility check result does not correspond to the selected server',
      );
    }

    return state.uri;
  }
}

@immutable
@freezed
class const LocalDiscoveryState({
  required final List<DiscoveredServer> discoveredServers,

  /// Should be only used if [ServerSelectionState.selectionMethod] is [ServerSelectionMethod.localNetworkDiscovery].
  required final String? selectedServerId,
  required final bool isLoading,
  required final bool hasLoadedOnce,
}) with _$LocalDiscoveryState {
  const new initial()
    : this(
        discoveredServers: const [],
        selectedServerId: null,
        isLoading: false,
        hasLoadedOnce: false,
      );
}

@freezed
@immutable
sealed class SelectedServer with _$SelectedServer {
  /// The server base URL provided by the user to connect to the server.
  const factory manual(String address) = Manual;

  /// Uses the server hosting the web application.
  const factory useWebAppServer() = UseWebAppServer;

  /// Pointer to an item in [LocalDiscoveryState.discoveredServers] list.
  /// Uses [DiscoveredServer.id].
  const factory discovered(String id) = Discovered;
}

extension ServerSelectionStateExt on ServerSelectionState {
  SelectedServer? get selectedServer {
    final discovered = discoveryState.selectedServerId;
    final manual = manualServerAddress;

    return switch (selectionMethod) {
      .localNetworkDiscovery =>
        discovered != null ? .discovered(discovered) : null,
      .manual => manual != null ? .manual(manual) : null,
      .useWebAppServer => const .useWebAppServer(),
    };
  }
}

@immutable
@freezed
sealed class ServerCompatibilityCheckState
    with _$ServerCompatibilityCheckState {
  /// No compatibility result exists yet.
  const factory initial() = Initial;

  const factory load() = Load;
  const factory success(
    ServerCompatibilityCheckResponse response,
    SelectedServer server,
    Uri uri,
  ) = Success;
  const factory failure(ApiRequestFailure failure) = Failure;
}
