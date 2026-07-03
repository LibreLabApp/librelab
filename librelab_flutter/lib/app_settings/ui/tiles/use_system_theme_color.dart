import 'package:flutter/material.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:provider/provider.dart';

class const UseSystemThemeColorListTile({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final useSystemColors = context.select(
      (AppSettingsCubit v) => v.state.settings.appearance.useSystemColors,
    );
    final t = context.t.settings.useSystemColors;

    return SwitchListTile(
      value: useSystemColors,
      title: Text(t.title),
      subtitle: Text(t.subtitle),
      secondary: const Icon(Icons.palette),
      onChanged: (value) {
        final cubit = context.read<AppSettingsCubit>();
        cubit.update(
          cubit.state.settings.copyWith.appearance(useSystemColors: value),
        );
      },
    );
  }
}
