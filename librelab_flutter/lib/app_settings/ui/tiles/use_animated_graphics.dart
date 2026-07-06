import 'package:flutter/material.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:provider/provider.dart';

class const UseAnimatedGraphicsListTile({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final useAnimatedGraphics = context.select(
      (AppSettingsCubit v) => v.state.settings.appearance.useAnimatedGraphics,
    );
    final t = context.t.settings.useAnimatedGraphics;

    return SwitchListTile(
      value: useAnimatedGraphics,
      title: Text(t.title),
      subtitle: Text(t.subtitle),
      secondary: const Icon(Icons.bug_report),
      onChanged: (value) {
        final cubit = context.read<AppSettingsCubit>();
        cubit.update(
          cubit.state.settings.copyWith.appearance(useAnimatedGraphics: value),
        );
      },
    );
  }
}
