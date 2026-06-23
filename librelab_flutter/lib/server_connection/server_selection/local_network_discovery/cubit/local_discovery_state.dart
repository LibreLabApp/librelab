// ignore_for_file: annotate_overrides

part of 'local_discovery_cubit.dart';

@immutable
@freezed
class const LocalDiscoveryState({
  required final List<DiscoveredServer> discoveredServers,
  required final String? selectedServerId,
  required final bool isLoading,
  required final bool hasLoadedOnce,
}) with _$LocalDiscoveryState {
  factory initialState() => const LocalDiscoveryState(
    discoveredServers: [],
    selectedServerId: null,
    isLoading: false,
    hasLoadedOnce: false,
  );
}
