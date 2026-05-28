part of 'stepper_view.dart';

extension StepperViewVertical on StepperView {
  Widget _vertical({
    required _StepTileData Function(int index) stepDataBuilder,
  }) {
    return Column(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (i) {
        final stepData = stepDataBuilder(i);
        final widget = _VerticalStepTile(stepData: stepData);
        return builder?.call(i, widget) ?? widget;
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
          child: ListTile(
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
            onTap: onStepTapped != null ? () => onStepTapped.call(index) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
