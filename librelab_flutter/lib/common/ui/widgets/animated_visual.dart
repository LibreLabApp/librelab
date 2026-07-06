import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:provider/provider.dart';

class const AnimatedVisual({
  super.key,
  required final Widget Function(BuildContext context) _animated,
  required final Widget Function(BuildContext context) _fallback,
}) extends StatelessWidget {
  static const bool supported = !kIsWeb;

  @override
  Widget build(BuildContext context) {
    final useAnimatedGraphics = context.select(
      (AppSettingsCubit v) => v.state.settings.appearance.useAnimatedGraphics,
    );
    if (useAnimatedGraphics && supported) {
      return _animated(context);
    }

    return _fallback(context);
  }
}
