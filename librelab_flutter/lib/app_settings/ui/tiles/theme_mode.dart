import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/app_settings/app_settings.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/adaptive_toggle_group.dart';

class const ThemeModeListTile({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = context.t.settings.themeMode;

    return ListTile(
      title: Text(t.title),
      leading: Icon(
        context.theme.brightness == Brightness.dark
            ? Icons.nightlight
            : Icons.wb_sunny_outlined,
      ),
      trailing: _OptionButtons(),
    );
  }
}

class _OptionButtons extends StatelessWidget {
  (IconData icon, String tooltip) _iconAndTooltip(
    BuildContext context,
    AppThemeMode mode,
  ) {
    final t = context.t.settings.themeMode;
    return switch (mode) {
      .system => (Icons.settings, t.options.system),
      .dark => (Icons.dark_mode, t.options.dark),
      .light => (Icons.light_mode, t.options.light),
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.select(
      (AppSettingsCubit v) => v.state.settings.appearance.themeMode,
    );

    return AdaptiveToggleGroup<AppThemeMode>(
      items: AppThemeMode.values.map((e) {
        final (icon, tooltip) = _iconAndTooltip(context, e);

        return ActionToggleItem<AppThemeMode>(
          value: e,
          icon: Icon(icon),
          tooltip: tooltip,
        );
      }).toList(),
      selected: themeMode,
      onSelectionChanged: (context, value) => _onChanged(context, value),
    );
  }
}

void _onChanged(BuildContext context, AppThemeMode value) {
  final cubit = context.read<AppSettingsCubit>();
  cubit.update(cubit.state.settings.copyWith.appearance(themeMode: value));
}
