part of 'stepper_view.dart';

extension StepperViewHorizontal on StepperView {
  Widget _horizontal({
    required ThemeData theme,
    required _StepTileData Function(int index) stepDataBuilder,
  }) {
    return Row(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (i) {
        final widget = _HorizontalStepTile(stepData: stepDataBuilder(i));
        return builder?.call(i, widget) ?? widget;
      }),
    );
  }
}

class _HorizontalStepTile extends StatelessWidget {
  const _HorizontalStepTile({required this.stepData});

  final _StepTileData stepData;

  double _dividerWidth({required double screenWidth}) {
    if (screenWidth <= 366) {
      return 0;
    }
    if (screenWidth <= 380) {
      return 8;
    }
    if (screenWidth <= 400) {
      return 12;
    }
    if (screenWidth <= 460) {
      return 16;
    }
    if (screenWidth <= 500) {
      return 32;
    }
    return 36;
  }

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

    final width = MediaQuery.widthOf(context);
    final dividerWidth = _dividerWidth(screenWidth: width);

    return Row(
      children: [
        GestureDetector(
          onTap: () => onStepTapped?.call(index),
          child: Column(
            spacing: 4,
            children: [
              _StepIcon(index: index, state: stepState),
              SizedBox(
                width: 80,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: dividerWidth,
              height: 2,
              color: theme.dividerColor,
            ),
          ),
      ],
    );
  }
}
