import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:freezed_annotation/freezed_annotation.dart';

// Import only for referencing LocalDiscoveryState in doc comments
import 'package:librelab_flutter/server_selection/local_network_discovery/cubit/local_discovery_cubit.dart'
    show LocalDiscoveryState;

part 'server_selection_cubit.freezed.dart';
part 'server_selection_state.dart';

class ServerSelectionCubit extends Cubit<ServerSelectionState> {
  ServerSelectionCubit() : super(const .initialState());

  void setManualServerUrl(String value) {
    emit(state.copyWith(manualServerUrl: value));
  }

  /// Must not be called on the web
  void setSelectionMethod(ServerSelectionMethod method) {
    if (kIsWeb) {
      throw UnsupportedError(
        'Selection method must not be changed on the web (default is fixed: ${state.selectionMethod}).',
      );
    }
    emit(state.copyWith(selectionMethod: method));
  }
}
