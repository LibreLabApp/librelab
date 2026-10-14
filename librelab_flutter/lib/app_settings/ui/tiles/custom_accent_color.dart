import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

/// A list tile for customizing and enabling or disabling the custom accent color.
class const CustomAccentColorListTile({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accentColor = Color(
      context.select(
        (AppSettingsCubit v) => v.state.settings.appearance.accentColor,
      ),
    );
    final useAccentColor = context.select(
      (AppSettingsCubit v) => v.state.settings.appearance.useAccentColor,
    );
    final useSystemColors = context.select(
      (AppSettingsCubit v) => v.state.settings.appearance.useSystemColors,
    );

    final t = context.t.settings.customAccentColor;

    final VoidCallback? onSelect = useSystemColors
        ? null
        : () => _pickAColor(context, accentColor: accentColor);

    return ListTile(
      leading: const Icon(Icons.colorize),
      title: Text(t.title),
      subtitle: Text(t.subtitle),
      trailing: Row(
        mainAxisSize: .min,
        spacing: 6,
        children: [
          ColorIndicator(
            width: 30,
            height: 30,
            borderRadius: 32,
            color: accentColor,
            onSelect: onSelect,
          ),
          () {
            final widget = Switch(
              value: useAccentColor,
              onChanged: useSystemColors
                  ? null
                  : (value) => _onChanged(context, value),
            );
            if (useSystemColors) {
              return Tooltip(message: t.disabledTooltip, child: widget);
            }
            return widget;
          }(),
        ],
      ),
      onTap: onSelect,
    );
  }

  Future<void> _pickAColor(
    BuildContext context, {
    required Color accentColor,
  }) async {
    final cubit = context.read<AppSettingsCubit>();

    Color? pickedColor;

    await showDialog<void>(
      context: context,
      builder: (context) {
        final t = context.t.settings.customAccentColor.pickColorDialog;

        return AlertDialog(
          title: Text(t.title),
          content: ConstrainedBox(
            constraints: const .new(maxHeight: 400, maxWidth: 400),
            child: SingleChildScrollView(
              child: ColorPicker(
                color: accentColor,
                onColorChanged: (color) => pickedColor = color,
                pickersEnabled: const {ColorPickerType.wheel: true},
              ),
            ),
          ),
          actions: [TextButton(onPressed: context.pop, child: Text(t.close))],
        );
      },
    );

    final newColor = pickedColor;
    if (newColor == null) {
      return;
    }

    await cubit.update(
      cubit.state.settings.copyWith.appearance(
        accentColor: newColor.toARGB32(),
      ),
    );
  }

  void _onChanged(BuildContext context, bool value) {
    final cubit = context.read<AppSettingsCubit>();
    cubit.update(
      cubit.state.settings.copyWith.appearance(useAccentColor: value),
    );
  }
}
