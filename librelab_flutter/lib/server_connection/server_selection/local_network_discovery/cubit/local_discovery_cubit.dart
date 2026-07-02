import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/common/bloc_ext.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/discovered_server.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/local_discovery_repository.dart';

part 'local_discovery_state.dart';
part 'local_discovery_cubit.freezed.dart';

class LocalDiscoveryCubit extends Cubit<LocalDiscoveryState> {
  LocalDiscoveryCubit({required this._localDiscoveryRepository})
    : super(LocalDiscoveryState.initialState()) {
    _streamSubscription = _localDiscoveryRepository.serversStream.listen(
      _onServersChanged,
    );
  }

  final LocalDiscoveryRepository _localDiscoveryRepository;

  late final StreamSubscription<List<DiscoveredServer>> _streamSubscription;

  void _onServersChanged(List<DiscoveredServer> servers) {
    final isSelectedServerStillPresent = servers
        .map((e) => e.id)
        .toList()
        .contains(state.selectedServerId);
    emitIfMounted(
      state.copyWith(
        discoveredServers: servers,
        // Clears selection if the previously selected server is no longer in the updated list
        selectedServerId: isSelectedServerStillPresent
            ? state.selectedServerId
            : null,
      ),
    );
  }

  /// Must not be called on the web
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
    emitIfMounted(state.copyWith(isLoading: false, hasLoadedOnce: true));

    _autoSelect();
  }

  void _autoSelect() {
    if (state.selectedServerId == null && state.discoveredServers.length == 1) {
      emitIfMounted(
        state.copyWith(selectedServerId: state.discoveredServers.first.id),
      );
    }
  }

  void selectServer(String? id) => emit(state.copyWith(selectedServerId: id));

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }
}
