import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/local_network_discovery/discovered_server.dart';
import 'package:librelab_flutter/local_network_discovery/repository.dart';

part 'local_discovery_state.dart';
part 'local_discovery_cubit.freezed.dart';

class LocalDiscoveryCubit extends Cubit<LocalDiscoveryState> {
  LocalDiscoveryCubit({
    required LocalDiscoveryRepository localDiscoveryRepository,
  }) : _localDiscoveryRepository = localDiscoveryRepository,
       super(LocalDiscoveryState.initialState()) {
    _streamSubscription = _localDiscoveryRepository.serversStream.listen(
      _onServersChanged,
    );
  }

  late final StreamSubscription<List<DiscoveredServer>> _streamSubscription;

  void _onServersChanged(List<DiscoveredServer> servers) {
    emit(state.copyWith(discoveredServers: servers));
  }

  final LocalDiscoveryRepository _localDiscoveryRepository;

  Future<void> scan({bool refresh = false}) async {
    if (state.isLoading) {
      return;
    }
    if (state.hasLoadedOnce && !refresh) {
      return;
    }
    emit(state.copyWith(isLoading: true, selectedServerId: null));

    unawaited(
      Future<void>.delayed(
        const Duration(seconds: 1),
      ).then((_) => _autoSelect()),
    );

    await _localDiscoveryRepository.scan();
    emit(state.copyWith(isLoading: false, hasLoadedOnce: true));

    _autoSelect();
  }

  void _autoSelect() {
    if (state.selectedServerId == null && state.discoveredServers.length == 1) {
      emit(state.copyWith(selectedServerId: state.discoveredServers.first.id));
    }
  }

  void selectServer(String? id) => emit(state.copyWith(selectedServerId: id));

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    // TODO: (MDNS) IS it the cubit respinbility to dispose this?
    await _localDiscoveryRepository.close();
    return super.close();
  }
}
