part of 'stepper_view.dart';

extension StepperViewVertical on StepperView {
  Widget _vertical({
    required _StepTileData Function(BuildContext context, int index)
    stepDataBuilder,
  }) {
    return Column(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (i) {
        return Builder(
          builder: (context) {
            final widget = _VerticalStepTile(
              stepData: stepDataBuilder(context, i),
            );
            return builder?.call(context, i, widget) ?? widget;
          },
        );
      }),
    );
  }
}

class _VerticalStepTile extends StatelessWidget {
  const _VerticalStepTile({required this.stepData});

  final _StepTileData stepData;

  @override
  Widget build(BuildContext context) {
    final (title, subtitle, index, isLast, stepState, onStepTapped) = (
      stepData.stepNav.title,
      stepData.stepNav.subtitle,
      stepData.index,
      stepData.isLast,
      stepData.stepState,
      stepData.onStepTapped,
    );

    final theme = Theme.of(context);
    final (textTheme, colorScheme) = (theme.textTheme, theme.colorScheme);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: Column(
            children: [
              _StepIcon(index: index, state: stepState),
              if (!isLast)
                Container(width: 2, height: 60, color: theme.dividerColor),
            ],
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              return ListTile(
                title: Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: stepState == .active
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
                tileColor: stepState == .active
                    ? colorScheme.primaryContainer
                    : null,
                onTap: onStepTapped != null
                    ? () => onStepTapped.call(context, index)
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
