// ignore_for_file: annotate_overrides

part of 'server_selection_cubit.dart';

enum ServerSelectionMethod { localNetworkDiscovery, manual }

@freezed
@immutable
class const ServerSelectionState({
  required final ServerSelectionMethod selectionMethod,

  /// The server base URL provided by the user to connect to the server.
  ///
  /// Should be only used if [selectionMethod] is [ServerSelectionMethod.manual].
  ///
  /// if [selectionMethod] is [ServerSelectionMethod.localNetworkDiscovery],
  /// use [LocalDiscoveryState].
  ///
  required final String? manualServerUrl,
}) with _$ServerSelectionState {
  factory initialState() => const ServerSelectionState(
    selectionMethod: .localNetworkDiscovery,
    manualServerUrl: null,
  );
}
