part of 'server_selection_cubit.dart';

enum ServerSelectionMethod { localNetworkDiscovery, manual }

@freezed
@immutable
final class ServerSelectionState with _$ServerSelectionState {
  const ServerSelectionState({
    required this.selectionMethod,
    required this.manualServerUrl,
  });

  factory ServerSelectionState.initialState() => const ServerSelectionState(
    selectionMethod: .localNetworkDiscovery,
    manualServerUrl: null,
  );

  @override
  final ServerSelectionMethod selectionMethod;

  /// The server base URL provided by the user to connect to the server.
  ///
  /// Should be only used if [selectionMethod] is [ServerSelectionMethod.manual].
  ///
  /// if [selectionMethod] is [ServerSelectionMethod.localNetworkDiscovery],
  /// use [LocalDiscoveryState].
  ///
  @override
  final String? manualServerUrl;
}
