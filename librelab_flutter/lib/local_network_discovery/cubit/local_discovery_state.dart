part of 'local_discovery_cubit.dart';

@immutable
@freezed
final class LocalDiscoveryState with _$LocalDiscoveryState {
  const LocalDiscoveryState({
    required this.discoveredServers,
    required this.selectedServerId,
    required this.isLoading,
    required this.hasLoadedOnce,
  });

  factory LocalDiscoveryState.initialState() => const LocalDiscoveryState(
    discoveredServers: [],
    selectedServerId: null,
    isLoading: false,
    hasLoadedOnce: false,
  );

  @override
  final List<DiscoveredServer> discoveredServers;

  @override
  final String? selectedServerId;

  @override
  final bool isLoading;

  final bool hasLoadedOnce;
}
