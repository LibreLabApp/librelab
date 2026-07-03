import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/app_settings/app_settings.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';

class const ThemeModeListTile({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeMode = context.select(
      (AppSettingsCubit v) => v.state.settings.appearance.themeMode,
    );
    final t = context.t.settings.themeMode;

    return ListTile(
      title: Text(t.title),
      subtitle: Text(t.subtitle),
      leading: Icon(
        context.theme.brightness == Brightness.dark
            ? Icons.nightlight
            : Icons.wb_sunny_outlined,
      ),
      // TODO: The trailing is taking too much width on some real devices, leaving little space to the text
      trailing: SegmentedButton<AppThemeMode>(
        segments: AppThemeMode.values.map((e) {
          final (icon, tooltip) = switch (e) {
            .system => (Icons.settings, t.options.system),
            .dark => (Icons.nightlight_round, t.options.dark),
            .light => (Icons.wb_sunny, t.options.light),
          };
          return ButtonSegment<AppThemeMode>(
            value: e,
            icon: Icon(icon),
            tooltip: tooltip,
          );
        }).toList(),
        selected: <AppThemeMode>{themeMode},
        onSelectionChanged: (Set<AppThemeMode> newSelection) =>
            _onChanged(context, newSelection.first),
      ),
    );
  }
}

void _onChanged(BuildContext context, AppThemeMode value) {
  final cubit = context.read<AppSettingsCubit>();
  cubit.update(cubit.state.settings.copyWith.appearance(themeMode: value));
}
