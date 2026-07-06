import 'package:flutter/material.dart' hide Step;
import 'package:stepper_flow/src/step_access_evaluation_mode.dart';
import 'package:stepper_flow/src/stepper_flow/pager.dart';
import 'package:stepper_flow/src/stepper_flow/step.dart';
import 'package:stepper_flow/src/stepper_view/stepper_view.dart';

part 'sidebar.dart';

sealed class StepAccessDecision {
  const StepAccessDecision();

  String? get disabledReason {
    return switch (this) {
      StepAllowed() => null,
      StepDenied(:final reason) => reason,
    };
  }
}

final class StepAllowed extends StepAccessDecision {
  const StepAllowed();
}

final class StepDenied extends StepAccessDecision {
  const StepDenied(this.reason);

  final String reason;
}

typedef StepCanGoTo = StepAccessDecision Function(
  BuildContext context,
  int index,
  StepAccessEvaluationMode mode,
);

typedef StepChangedCallback = void Function(BuildContext context, int newIndex);

@immutable
class const NavigationButtonLabels({
  required final String next,
  required final String back,
});

class const StepperFlow({
  super.key,
  required final int _currentStepIndex,
  required final StepChangedCallback _onStepChanged,
  required final List<Step> _steps,
  required final StepHero _stepHero,
  required final StepCanGoTo _canGoTo,
  required final NavigationButtonLabels _navigationButtonLabels,
}) extends StatelessWidget {
  void _guardedOnStepChanged(BuildContext context, int index) {
    final String? disabledReason = _canGoTo(
      context,
      index,
      .interaction,
    ).disabledReason;
    if (disabledReason == null) {
      _onStepChanged(context, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_steps.isEmpty) {
      throw ArgumentError('steps must not be empty');
    }
    if (_currentStepIndex < 0 || _currentStepIndex >= _steps.length) {
      throw ArgumentError.value(
        _currentStepIndex,
        'currentStep',
        'must be in range 0 <= currentStep < steps.length (${_steps.length})',
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final usesSidebar = constraints.maxWidth >= 710;
        final Axis direction = usesSidebar ? .horizontal : .vertical;

        final step = _steps[_currentStepIndex];

        return Flex(
          direction: direction,
          spacing: 24,
          children: [
            SizedBox(
              width: direction == .horizontal ? 220 : null,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 24, start: 16),
                child: usesSidebar
                    ? _StepProgressIndicatorSidebar(
                        currentStepIndex: _currentStepIndex,
                        onStepChanged: _guardedOnStepChanged,
                        steps: _steps,
                        stepHero: _stepHero,
                        canGoTo: _canGoTo,
                      )
                    : _StepProgressIndicator(
                        direction: .horizontal,
                        currentStepIndex: _currentStepIndex,
                        onStepChanged: _guardedOnStepChanged,
                        steps: _steps,
                        canGoTo: _canGoTo,
                      ),
              ),
            ),
            Expanded(
              child: Card(
                margin: .zero,
                child: _StepContent(
                  usesSidebar: usesSidebar,
                  step: step,
                  currentStepIndex: _currentStepIndex,
                  stepsCount: _steps.length,
                  canGoTo: _canGoTo,
                  onStepChanged: _guardedOnStepChanged,
                  navigationButtonLabels: _navigationButtonLabels,
                  direction: direction,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class const _StepProgressIndicator({
  required final Axis direction,
  required final int currentStepIndex,
  required final StepChangedCallback onStepChanged,
  required final List<Step> steps,
  required final StepCanGoTo canGoTo,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StepperView(
      direction: direction,
      currentStepIndex: currentStepIndex,
      onStepTapped: onStepChanged,
      steps: steps.indexed.map((e) => e.$2.nav).toList(),
      isLocked: (context, i, mode) =>
          canGoTo(context, i, mode).disabledReason != null,
      builder: (context, i, child) {
        final String? disabledReason = canGoTo(
          context,
          i,
          .build,
        ).disabledReason;
        if (disabledReason != null) {
          return Tooltip(message: disabledReason, child: child);
        }
        return child;
      },
    );
  }
}

class const _StepContent({
  required final bool _usesSidebar,
  required final int _currentStepIndex,
  required final Step _step,
  required final int _stepsCount,
  required final StepCanGoTo _canGoTo,
  required final StepChangedCallback _onStepChanged,
  required final NavigationButtonLabels _navigationButtonLabels,
  required final Axis _direction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: switch (_direction) {
        Axis.horizontal => const EdgeInsets.all(24),
        Axis.vertical => const EdgeInsets.all(16),
      },
      child: Column(
        children: [
          _StepContentHeading(_step.contentHeading),
          const SizedBox(height: 32),
          Expanded(
            child: StepPager(
              usesSidebar: _usesSidebar,
              currentStepIndex: _currentStepIndex,
              stepBuilder: _step.stepBuilder,
              stepsCount: _stepsCount,
              onStepChanged: _onStepChanged,
              navigationButtonLabels: _navigationButtonLabels,
              canGoTo: _canGoTo,
            ),
          ),
        ],
      ),
    );
  }
}

class const _StepContentHeading(final StepContentHeading _contentHeading)
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      spacing: 24,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          child: Icon(_contentHeading.iconData),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 6,
            children: [
              Text(
                _contentHeading.title,
                style: textTheme.headlineMedium?.copyWith(fontWeight: .bold),
              ),
              Text(_contentHeading.subtitle),
            ],
          ),
        ),
      ],
    );
  }
}
