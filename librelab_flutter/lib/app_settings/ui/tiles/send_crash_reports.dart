import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_shared/librelab_shared.dart';

class const SendCrashReportsListTile({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sendCrashReports = context.select(
      (AppSettingsCubit v) => v.state.settings.telemetry.sendCrashReports,
    );
    final t = context.t.settings.sendCrashReports;

    return SwitchListTile(
      value: sendCrashReports,
      title: Text(t.title),
      subtitle: Text(t.subtitle(appName: ProjectConstants.displayName)),
      secondary: const Icon(Icons.bug_report),
      onChanged: (value) {
        final cubit = context.read<AppSettingsCubit>();
        cubit.update(
          cubit.state.settings.copyWith.telemetry(sendCrashReports: value),
        );
      },
    );
  }
}
