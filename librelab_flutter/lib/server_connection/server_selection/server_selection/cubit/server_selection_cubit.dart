import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Import only for referencing LocalDiscoveryState in doc comments
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/cubit/local_discovery_cubit.dart'
    show LocalDiscoveryState;

part 'server_selection_cubit.freezed.dart';
part 'server_selection_state.dart';

class ServerSelectionCubit extends Cubit<ServerSelectionState> {
  ServerSelectionCubit() : super(ServerSelectionState.initialState());

  void setManualServerUrl(String value) {
    emit(state.copyWith(manualServerUrl: value));
  }

  void setSelectionMethod(ServerSelectionMethod method) {
    emit(state.copyWith(selectionMethod: method));
  }
}
