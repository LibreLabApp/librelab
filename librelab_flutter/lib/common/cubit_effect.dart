import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

abstract class EffectCubit<State, Effect> extends Cubit<State> {
  EffectCubit(super.initialState);

  final _effects = StreamController<Effect>.broadcast();

  Stream<Effect> get effects => _effects.stream;

  @protected
  @visibleForTesting
  void emitEffect(Effect effect) => _effects.add(effect);

  @override
  Future<void> close() async {
    await _effects.close();
    return super.close();
  }
}
