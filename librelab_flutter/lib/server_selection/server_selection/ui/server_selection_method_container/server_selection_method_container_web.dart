import 'package:flutter/material.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';

Widget buildServerSelectionMethodContainer(
  BuildContext context,
  ServerSelectionMethod selectedMethod,
  ServerSelectionCubit cubit, {
  required Form Function() serverAddressTextField,
}) {
  final t = context.t.serverSelection.browserPlatform;

  final colorScheme = context.theme.colorScheme;

  return Container(
    padding: const EdgeInsets.all(16.0),
    margin: const EdgeInsets.only(bottom: 16.0),
    decoration: BoxDecoration(
      color: colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: colorScheme.outlineVariant, width: 1.0),
    ),
    child: RadioGroup<ServerSelectionMethod>(
      onChanged: (value) => cubit.setSelectionMethod(
        value ??
            (throw StateError(
              'New $ServerSelectionMethod must not be null (RawRadio.toggleable should be false)',
            )),
      ),
      groupValue: selectedMethod,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          _Option(
            .useWebAppServer,
            onTap: () => cubit.setSelectionMethod(.useWebAppServer),
            isSelected: selectedMethod == .useWebAppServer,
            title: t.useWebAppServer.title,
            subtitle: t.useWebAppServer.subtitle,
            content: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${t.useWebAppServer.serverAddressLabel} '),
                  TextSpan(
                    text: Uri.base.origin,
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ],
              ),
            ),
            badge: const _CurrentServerBadge(),
          ),
          _Or(t.or),
          _Option(
            .manual,
            onTap: () => cubit.setSelectionMethod(.manual),
            isSelected: selectedMethod == .manual,
            title: t.manualAddress.title,
            subtitle: t.manualAddress.subtitle,
            content: serverAddressTextField(),
            badge: null,
          ),
        ],
      ),
    ),
  );
}

class const _Option(
  final ServerSelectionMethod method, {
  required final bool isSelected,
  required final String title,
  required final String subtitle,
  required final Widget content,
  required final GestureTapCallback onTap,
  required final Widget? badge,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Radio(value: method),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? context.theme.colorScheme.primary : null,
                ),
              ),
              const Spacer(),
              ?badge,
            ],
          ),
          Padding(
            padding: const .directional(start: 42),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(subtitle),
                const SizedBox(height: 12),
                if (isSelected) content,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _Or(final String text) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(text),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

class const _CurrentServerBadge() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.language_rounded,
            size: 14,
            color: colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            context.t.serverSelection.browserPlatform.useWebAppServer.badge,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
