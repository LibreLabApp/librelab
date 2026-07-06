import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

extension BlocExt<State> on BlocBase<State> {
  /// Emits state only if cubit/bloc is still active after async gaps.
  @protected
  void emitIfMounted(State state) {
    if (isClosed) {
      return;
    }
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    emit(state);
  }
}
