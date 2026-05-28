import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stepper_flow/src/stepper_flow/step.dart';
import 'package:stepper_flow/src/stepper_flow/stepper_flow.dart';

class Pager extends StatelessWidget {
  const Pager({
    super.key,
    required this.usesSidebar,
    required this.currentStepIndex,
    required this.stepBuilder,
    required this.stepsCount,
    required this.onStepChanged,
    required this.navigationButtonLabels,
    required this.canGoTo,
  });

  final bool usesSidebar;
  final int currentStepIndex;
  final int stepsCount;
  final StepBuilder stepBuilder;
  final StepChangedCallback onStepChanged;
  final NavigationButtonLabels navigationButtonLabels;
  final StepCanGoTo canGoTo;

  void _onPageChanged(int index) {
    onStepChanged(index);
  }

  Widget _stepContent({required BuildContext context}) => Expanded(
    child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },

      /// Prevents AnimatedSwitcher from centering the child (see [AnimatedSwitcher.defaultLayoutBuilder])
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.topLeft,
        children: [...previousChildren, ?currentChild],
      ),
      child: KeyedSubtree(
        key: ValueKey(currentStepIndex),
        child: SingleChildScrollView(child: stepBuilder(context)),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _stepContent(context: context),
        const SizedBox(height: 2),
        Builder(
          builder: (context) {
            final showHorizontally = !usesSidebar;
            final navigationButtons = _NavigationButtons(
              navigationButtonLabels: navigationButtonLabels,
              canGoTo: canGoTo,
              currentStepIndex: currentStepIndex,
              onStepChanged: onStepChanged,
              stepsCount: stepsCount,
            );

            final indicator = AnimatedSmoothIndicator(
              activeIndex: currentStepIndex,
              count: stepsCount,
              effect: JumpingDotEffect(
                activeDotColor: theme.colorScheme.primary,
              ),
              onDotClicked: _onPageChanged,
            );

            if (showHorizontally) {
              return Row(
                mainAxisAlignment: .spaceBetween,
                spacing: 8,
                children: [indicator, navigationButtons],
              );
            }

            return Column(
              spacing: 12,
              children: [navigationButtons, indicator],
            );
          },
        ),
      ],
    );
  }
}

class _NavigationButtons extends StatelessWidget {
  const _NavigationButtons({
    required this.canGoTo,
    required this.navigationButtonLabels,
    required this.onStepChanged,
    required this.currentStepIndex,
    required this.stepsCount,
  });

  final StepCanGoTo canGoTo;
  final NavigationButtonLabels navigationButtonLabels;
  final StepChangedCallback onStepChanged;
  final int currentStepIndex;
  final int stepsCount;

  void _moveStep({required bool forward}) {
    final newIndex = currentStepIndex + (forward ? 1 : -1);
    if (newIndex == -1 || newIndex >= stepsCount) {
      return;
    }
    onStepChanged(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        OutlinedButton(
          onPressed: () => _moveStep(forward: false),
          child: Text(navigationButtonLabels.back),
        ),
        Builder(
          builder: (context) {
            final String? disabledReason = canGoTo(
              currentStepIndex + 1,
            ).disabledReason;

            return Tooltip(
              message: disabledReason ?? '',
              child: FilledButton.icon(
                onPressed: disabledReason != null
                    ? null
                    : () => _moveStep(forward: true),
                label: Text(navigationButtonLabels.next),
                icon: const Icon(Icons.arrow_forward_outlined),
                iconAlignment: IconAlignment.end,
                style: FilledButton.styleFrom(
                  disabledBackgroundColor: colorScheme.onSurface.withValues(
                    alpha: 0.12,
                  ),
                  disabledForegroundColor: colorScheme.onSurface.withValues(
                    alpha: 0.38,
                  ),
                  disabledIconColor: colorScheme.onSurface.withValues(
                    alpha: 0.38,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
