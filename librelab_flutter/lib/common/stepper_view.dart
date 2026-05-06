import 'package:flutter/material.dart';
import 'package:librelab_flutter/common/build_context_ext.dart';

/// Flutter's [Stepper]
/// is [Material 2 widget](https://docs.flutter.dev/ui/widgets/material2)
/// and will be deprecated eventually.
class StepperView extends StatelessWidget {
  const StepperView({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.onStepTapped,
  });

  final List<StepData> steps;
  final int currentStep;
  final void Function(int newIndex) onStepTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (i) {
        final step = steps[i];

        return _StepTile(
          index: i,
          title: step.title,
          subtitle: step.subtitle,
          isActive: currentStep == i,
          isLast: i == steps.length - 1,
          onStepTapped: onStepTapped,
        );
      }),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.isLast,
    required this.onStepTapped,
  });

  final int index;
  final String title;
  final String subtitle;
  final bool isActive;
  final bool isLast;
  final void Function(int newIndex) onStepTapped;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final (textTheme, colorScheme) = (theme.textTheme, theme.colorScheme);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isActive
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: isActive
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              if (!isLast)
                Container(width: 2, height: 60, color: theme.dividerColor),
            ],
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isActive
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            tileColor: isActive ? colorScheme.primaryContainer : null,
            onTap: () => onStepTapped(index),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

@immutable
final class StepData {
  const StepData(this.title, this.subtitle);

  final String title;
  final String subtitle;
}
