import 'package:flutter/material.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/generated/assets.gen.dart';
import 'package:lottie/lottie.dart';

/// Indicates that this feature or area of the app is under active development
/// and is not ready for general use.
class WorkInProgress extends StatelessWidget {
  const WorkInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    final t = context.t.workInProgress;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
          child: Lottie.asset(
            Assets.lottie.underConstruction,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          t.title,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          t.subtitle,
          style: textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).hintColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
