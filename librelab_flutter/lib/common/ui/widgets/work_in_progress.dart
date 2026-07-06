import 'package:flutter/material.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/animated_visual.dart';
import 'package:librelab_flutter/common/ui/widgets/decorative_icon.dart';
import 'package:librelab_flutter/generated/assets.gen.dart';
import 'package:lottie/lottie.dart';

/// Indicates that this feature or area of the app is under active development
/// and is not ready for general use.
class const WorkInProgress({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    final t = context.t.workInProgress;

    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
          child: AnimatedVisual(
            animated: (context) => Lottie.asset(
              Assets.lottie.underConstruction,
              fit: BoxFit.contain,
            ),
            fallback: (context) => const Column(
              mainAxisSize: .min,
              children: [
                SizedBox(height: 32),
                DecorativeIcon(Icons.construction_rounded),
              ],
            ),
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
