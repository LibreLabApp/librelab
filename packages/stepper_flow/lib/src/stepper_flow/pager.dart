import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stepper_flow/src/stepper_flow/step.dart';
import 'package:stepper_flow/src/stepper_flow/stepper_flow.dart';

class const StepPager({
  super.key,
  required final bool _usesSidebar,
  required final int _currentStepIndex,
  required final int _stepsCount,
  required final StepBuilder _stepBuilder,
  required final StepChangedCallback _onStepChanged,
  required final NavigationButtonLabels _navigationButtonLabels,
  required final StepCanGoTo _canGoTo,
}) extends StatelessWidget {
  void _onPageChanged(BuildContext context, int index) {
    _onStepChanged(context, index);
  }

  Widget _stepContentBody({required BuildContext context}) => Expanded(
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
        key: ValueKey(_currentStepIndex),
        child: SingleChildScrollView(child: _stepBuilder(context)),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _stepContentBody(context: context),
        const SizedBox(height: 2),
        Builder(
          builder: (context) {
            final showHorizontally = !_usesSidebar;
            final navigationButtons = _NavigationButtons(
              navigationButtonLabels: _navigationButtonLabels,
              canGoTo: _canGoTo,
              currentStepIndex: _currentStepIndex,
              onStepChanged: _onStepChanged,
              stepsCount: _stepsCount,
            );

            final indicator = AnimatedSmoothIndicator(
              activeIndex: _currentStepIndex,
              count: _stepsCount,
              effect: JumpingDotEffect(
                activeDotColor: theme.colorScheme.primary,
              ),
              onDotClicked: (i) => _onPageChanged(context, i),
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

  void _moveStep(BuildContext context, {required bool forward}) {
    final newIndex = currentStepIndex + (forward ? 1 : -1);
    if (newIndex == -1 || newIndex >= stepsCount) {
      return;
    }
    onStepChanged(context, newIndex);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        Builder(
          builder: (context) {
            return OutlinedButton(
              onPressed: () => _moveStep(context, forward: false),
              child: Text(navigationButtonLabels.back),
            );
          },
        ),
        Builder(
          builder: (context) {
            final String? disabledReason = canGoTo(
              context,
              currentStepIndex + 1,
              .build,
            ).disabledReason;

            return Tooltip(
              message: disabledReason ?? '',
              child: FilledButton.icon(
                onPressed: disabledReason != null
                    ? null
                    : () => _moveStep(context, forward: true),
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
