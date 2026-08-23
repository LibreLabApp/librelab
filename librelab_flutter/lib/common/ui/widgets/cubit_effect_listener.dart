import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:librelab_flutter/common/cubit_effect.dart';
import 'package:provider/provider.dart';

class const CubitEffectListener<C extends CubitEffect<S, Effect>, S, Effect>({
  super.key,
  required final void Function(BuildContext context, Effect effect) listener,
  required final Widget child,
}) extends StatefulWidget {
  @override
  State<CubitEffectListener<C, S, Effect>> createState() =>
      _CubitEffectListenerState<C, S, Effect>();
}

class _CubitEffectListenerState<C extends CubitEffect<S, Effect>, S, Effect>
    extends State<CubitEffectListener<C, S, Effect>> {
  late final StreamSubscription<Effect> _effectSubscription;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<C>();

    _effectSubscription = cubit.effects.listen((effect) {
      if (mounted) {
        widget.listener(context, effect);
      }
    });
  }

  @override
  void dispose() {
    _effectSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
