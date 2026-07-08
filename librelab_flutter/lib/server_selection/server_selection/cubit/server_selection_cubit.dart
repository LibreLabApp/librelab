import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/common/bloc_ext.dart';
import 'package:librelab_flutter/common/cubit_effect.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_compatibility_check_response.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_compatibility_repository.dart';

import 'package:librelab_flutter/server_selection/local_network_discovery/discovered_server.dart';
import 'package:librelab_flutter/server_selection/local_network_discovery/local_discovery_repository.dart';
import 'package:librelab_flutter/server_selection/server_selection/server_selection_method.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:librelab_shared/result.dart';
import 'package:logging/logging.dart';

export 'package:librelab_flutter/server_selection/server_selection/server_selection_method.dart';

part 'server_selection_cubit.freezed.dart';
part 'server_selection_state.dart';
part 'server_selection_effect.dart';

class ServerSelectionCubit({
  required final LocalDiscoveryRepository _discoveryRepository,
  required final ServerCompatibilityRepository _serverCompatibilityRepository,
  required final Logger _logger,
}) extends EffectCubit<ServerSelectionState, ServerSelectionEffect> {
  this : super(const .initial());

  void setManualServerAddress(String value) {
    if (value == state.manualServerAddress) {
      return;
    }
    emit(state.copyWith(manualServerAddress: value));
  }

  late final LocalNetworkDiscoveryController? _localNetworkDiscovery = kIsWeb
      ? null
      : LocalNetworkDiscoveryController(
          state: () => state,
          emit: (state) => emit(state),
          emitIfMounted: (state) => emitIfMounted(state),
          repository: _discoveryRepository,
        );

  /// Must not be called on the web.
  LocalNetworkDiscoveryController get localNetworkDiscovery {
    if (kIsWeb) {
      throw UnsupportedError(
        'Local network discovery is not supported natively on the web.',
      );
    }
    return _localNetworkDiscovery ??
        (throw StateError(
          '$LocalNetworkDiscoveryController must be not-null on non-web platforms',
        ));
  }

  void setSelectionMethod(ServerSelectionMethod method) {
    if (kIsWeb && method == .localNetworkDiscovery ||
        !kIsWeb && method == .useWebAppServer) {
      throw ArgumentError.value(
        method,
        'method'
        'must not be changed to ${method.name} on this platform (current: ${state.selectionMethod}).',
      );
    }
    emit(state.copyWith(selectionMethod: method));
  }

  Future<void> checkServerCompatibility() async {
    if (state.selectionMethod == .manual) {
      final input = state.manualServerAddress ?? '';
      final isInvalid = validateHttpUrl(input) != null;
      if (isInvalid) {
        emitEffect(const .focusServerAddress());
        return;
      }
    }

    final selectedServer = state.selectedServer;
    if (selectedServer == null) {
      emitEffect(const .showServerSelectionRequired());
      return;
    }

    final ServerTarget serverTarget = switch (selectedServer) {
      Manual(:final address) => .manual(Uri.parse(address)),
      Discovered(:final id) => () {
        final server = state.discoveryState.discoveredServers.firstWhere(
          (e) => e.id == id,
        );
        return ServerTarget.discoveredServer(
          hostnameAuthority: server.authority,
          ipAddressAuthority: server.ipAddressAuthority,
        );
      }(),

      /// Web only: Uses the server hosting the web application as the API server.
      ///
      /// Internally represented by an empty URI, which resolves requests against the
      /// browser's current origin.
      UseWebAppServer() => ServerTarget.manual(Uri()),
    };

    emit(state.copyWith(compatibilityCheckState: const .load()));

    final request = await _serverCompatibilityRepository.check(serverTarget);

    switch (request.result) {
      case SuccessResult(:final value):
        emit(
          state.copyWith(
            compatibilityCheckState: .success(
              value,
              selectedServer,
              request.uri,
            ),
          ),
        );

      case FailureResult(:final failure):
        emit(state.copyWith(compatibilityCheckState: .failure(failure)));
        _logger.warning(
          'Failed to check server compatibility for ${serverTarget.endpoint}',
          failure.message,
        );
    }
  }

  @override
  Future<void> close() async {
    await _localNetworkDiscovery?._close();
    return super.close();
  }
}

class LocalNetworkDiscoveryController({
  // required final ServerSelectionCubit _cubit,
  required final ServerSelectionState Function() _state,
  required final void Function(ServerSelectionState state) _emit,
  required final void Function(ServerSelectionState state) _emitIfMounted,
  required final LocalDiscoveryRepository _repository,
}) {
  this {
    _streamSubscription = _repository.serversStream.listen(_onServersChanged);
  }

  late final StreamSubscription<List<DiscoveredServer>> _streamSubscription;

  ServerSelectionState get state => _state();

  void emit(ServerSelectionState state) => _emit(state);

  void emitIfMounted(ServerSelectionState state) => _emitIfMounted(state);

  void _onServersChanged(List<DiscoveredServer> servers) {
    final selectedServerId = state.discoveryState.selectedServerId;

    final isSelectedServerStillPresent = servers
        .map((e) => e.id)
        .toList()
        .contains(selectedServerId);

    emitIfMounted(
      state.copyWith.discoveryState(
        discoveredServers: servers,
        // Clears selection if the previously selected server is no longer in the updated list
        selectedServerId: isSelectedServerStillPresent
            ? selectedServerId
            : null,
      ),
    );
  }

  /// Must not be called on the web
  Future<void> scan({bool refresh = false}) async {
    final discoveryState = state.discoveryState;

    if (discoveryState.isLoading) {
      return;
    }
    if (discoveryState.hasLoadedOnce && !refresh) {
      return;
    }

    emit(
      state.copyWith.discoveryState(isLoading: true, selectedServerId: null),
    );

    unawaited(
      Future<void>.delayed(
        const Duration(seconds: 1),
      ).then((_) => _autoSelect()),
    );

    await _repository.scan();
    emitIfMounted(
      state.copyWith.discoveryState(isLoading: false, hasLoadedOnce: true),
    );

    _autoSelect();
  }

  void _autoSelect() {
    final selectedServerId = state.discoveryState.selectedServerId;
    final discoveredServers = state.discoveryState.discoveredServers;

    if (selectedServerId == null && discoveredServers.length == 1) {
      emitIfMounted(
        state.copyWith.discoveryState(
          selectedServerId: discoveredServers.first.id,
        ),
      );
    }
  }

  void selectServer(String? id) =>
      emit(state.copyWith.discoveryState(selectedServerId: id));

  Future<void> _close() async {
    await _streamSubscription.cancel();
  }
}
