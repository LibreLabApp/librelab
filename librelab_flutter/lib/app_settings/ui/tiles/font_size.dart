import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:material_ui/material_ui.dart';

class const FontSizeListTile({super.key}) extends StatelessWidget {
  static const _minFontSizeScale = 0.7;
  static const _maxFontSizeScale = 1.3;
  static const _fontSizeScaleStep = 0.05;

  static int get _fontSizeScaleDivisions =>
      ((_maxFontSizeScale - _minFontSizeScale) / _fontSizeScaleStep).round();

  @override
  Widget build(BuildContext context) {
    final fontSizeScale = context.select(
      (AppSettingsCubit v) => v.state.settings.appearance.fontSizeScale,
    );
    final theme = context.theme;
    final t = context.t.settings.fontSize;

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.format_size),
          title: Text(t.title),
          subtitle: Text(t.subtitle),
          trailing: Text(
            '${(fontSizeScale * 100).round()}%',
            style: theme.textTheme.titleMedium,
          ),
        ),
        Slider(
          value: fontSizeScale,
          min: _minFontSizeScale,
          max: _maxFontSizeScale,
          divisions: _fontSizeScaleDivisions,
          onChanged: (value) {
            final cubit = context.read<AppSettingsCubit>();
            cubit.update(
              cubit.state.settings.copyWith.appearance(fontSizeScale: value),
            );
          },
        ),
      ],
    );
  }
}
