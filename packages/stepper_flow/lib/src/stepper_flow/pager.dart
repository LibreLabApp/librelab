import 'package:material_ui/material_ui.dart';
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
  required final FinishedCallback _onFinished,
  required final IsFinishingCallback _isFinishing,
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
              onFinished: _onFinished,
              isFinishing: _isFinishing,
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

class const _NavigationButtons({
  required final StepCanGoTo canGoTo,
  required final NavigationButtonLabels navigationButtonLabels,
  required final StepChangedCallback onStepChanged,
  required final FinishedCallback onFinished,
  required final IsFinishingCallback _isFinishing,
  required final int currentStepIndex,
  required final int stepsCount,
}) extends StatelessWidget {
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
            final result = canGoTo(context, currentStepIndex + 1, .build);
            final String? disabledReason = result.disabledReason;

            final isFinishing = _isFinishing(context);

            return Tooltip(
              message: disabledReason ?? '',
              child: FilledButton.icon(
                onPressed: disabledReason != null || isFinishing
                    ? null
                    : () {
                        if (result is StepFinal) {
                          onFinished(context);
                        } else {
                          _moveStep(context, forward: true);
                        }
                      },
                label: Text(
                  result is StepFinal
                      ? navigationButtonLabels.finish
                      : navigationButtonLabels.next,
                ),
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isFinishing
                      ? const SizedBox(
                          key: ValueKey('loading'),
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(
                          Icons.arrow_forward_outlined,
                          key: ValueKey('arrow'),
                        ),
                ),
                iconAlignment: .end,
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
