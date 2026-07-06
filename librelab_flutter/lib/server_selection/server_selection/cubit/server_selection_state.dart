// ignore_for_file: annotate_overrides

part of 'server_selection_cubit.dart';

@freezed
@immutable
class const ServerSelectionState({
  /// Defaults to [ServerSelectionMethod.manual] on web due to lack of
  /// native mDNS service discovery support.
  /// Must not use [ServerSelectionMethod.localNetworkDiscovery] on web.
  required final ServerSelectionMethod selectionMethod,

  /// Should be only used if [selectionMethod] is [ServerSelectionMethod.manual].
  required final String? manualServerAddress,

  required final LocalDiscoveryState discoveryState,
  required final ServerCompatibilityCheckState compatibilityCheckState,
}) with _$ServerSelectionState {
  const new initial()
    : this(
        selectionMethod: kIsWeb ? .manual : .localNetworkDiscovery,
        manualServerAddress: null,
        discoveryState: const .initial(),
        compatibilityCheckState: const .initial(),
      );
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

  /// Pointer to an item in [LocalDiscoveryState.discoveredServers] list.
  /// Uses [DiscoveredServer.id].
  ///
  const factory discovered(String id) = Discovered;
}

extension ServerSelectionStateExt on ServerSelectionState {
  SelectedServer? get selectedServer {
    final discovered = discoveryState.selectedServerId;
    final manual = manualServerAddress;

    return switch (selectionMethod) {
      ServerSelectionMethod.localNetworkDiscovery =>
        discovered != null ? .discovered(discovered) : null,
      ServerSelectionMethod.manual => manual != null ? .manual(manual) : null,
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
