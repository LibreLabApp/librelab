import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocExt<State> on BlocBase<State> {
  /// Emits state only if cubit/bloc is still active after async gaps.
  void emitIfMounted(State newState) {
    if (isClosed) {
      return;
    }
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    emit(newState);
  }
}
