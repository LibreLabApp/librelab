import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/app_settings/app_settings.dart';
import 'package:librelab_flutter/app_settings/ui/app_locale_labels.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';

class const AppLocaleListTile({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocale = context.select(
      (AppSettingsCubit v) => v.state.settings.locale,
    );
    final t = context.t.settings.locale;
    return ListTile(
      title: Text(t.title),
      leading: const Icon(Icons.language),
      // TODO: The trailing is taking too much width on some real devices, leaving little space for the text
      trailing: DropdownMenu(
        initialSelection: appLocale,
        onSelected: (value) {
          final cubit = context.read<AppSettingsCubit>();
          cubit.update(cubit.state.settings.copyWith(locale: value));
        },
        dropdownMenuEntries: [
          DropdownMenuEntry(value: null, label: t.systemDefault),
          ...AppLocale.values.map(
            (e) => DropdownMenuEntry(value: e, label: e.label),
          ),
        ],
      ),
    );
  }
}
