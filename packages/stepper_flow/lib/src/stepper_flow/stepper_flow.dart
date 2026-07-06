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
  required final int currentStepIndex,
  required final StepChangedCallback onStepChanged,
  required final List<Step> steps,
  required final StepHero stepHero,
  required final StepCanGoTo canGoTo,
  required final NavigationButtonLabels navigationButtonLabels,
}) extends StatelessWidget {
  void _guardedOnStepChanged(BuildContext context, int index) {
    final String? disabledReason = canGoTo(
      context,
      index,
      .interaction,
    ).disabledReason;
    if (disabledReason == null) {
      onStepChanged(context, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      throw ArgumentError('steps must not be empty');
    }
    if (currentStepIndex < 0 || currentStepIndex >= steps.length) {
      throw ArgumentError.value(
        currentStepIndex,
        'currentStep',
        'must be in range 0 <= currentStep < steps.length (${steps.length})',
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final usesSidebar = constraints.maxWidth >= 710;
        final Axis direction = usesSidebar ? .horizontal : .vertical;

        final step = steps[currentStepIndex];

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
                        currentStepIndex: currentStepIndex,
                        onStepChanged: _guardedOnStepChanged,
                        steps: steps,
                        stepHero: stepHero,
                        canGoTo: canGoTo,
                      )
                    : _StepProgressIndicator(
                        direction: .horizontal,
                        currentStepIndex: currentStepIndex,
                        onStepChanged: _guardedOnStepChanged,
                        steps: steps,
                        canGoTo: canGoTo,
                      ),
              ),
            ),
            Expanded(
              child: Card(
                margin: .zero,
                child: _Body(
                  usesSidebar: usesSidebar,
                  step: step,
                  currentStepIndex: currentStepIndex,
                  stepsCount: steps.length,
                  canGoTo: canGoTo,
                  onStepChanged: _guardedOnStepChanged,
                  navigationButtonLabels: navigationButtonLabels,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StepProgressIndicator extends StatelessWidget {
  const _StepProgressIndicator({
    required this.direction,
    required this.currentStepIndex,
    required this.onStepChanged,
    required this.steps,
    required this.canGoTo,
  });

  final Axis direction;
  final int currentStepIndex;
  final StepChangedCallback onStepChanged;
  final List<Step> steps;
  final StepCanGoTo canGoTo;

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

class _Body extends StatelessWidget {
  const _Body({
    required this.usesSidebar,
    required this.step,
    required this.stepsCount,
    required this.currentStepIndex,
    required this.canGoTo,
    required this.onStepChanged,
    required this.navigationButtonLabels,
  });

  final bool usesSidebar;
  final int currentStepIndex;
  final Step step;
  final int stepsCount;
  final StepCanGoTo canGoTo;
  final StepChangedCallback onStepChanged;
  final NavigationButtonLabels navigationButtonLabels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _StepContentHeading(step.contentHeading),
          const SizedBox(height: 32),
          Expanded(
            child: Pager(
              usesSidebar: usesSidebar,
              currentStepIndex: currentStepIndex,
              stepBuilder: step.stepBuilder,
              stepsCount: stepsCount,
              onStepChanged: onStepChanged,
              navigationButtonLabels: navigationButtonLabels,
              canGoTo: canGoTo,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepContentHeading extends StatelessWidget {
  const _StepContentHeading(this.contentHeading);

  final StepContentHeading contentHeading;

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
          child: Icon(contentHeading.iconData),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 6,
            children: [
              Text(
                contentHeading.title,
                style: textTheme.headlineMedium?.copyWith(fontWeight: .bold),
              ),
              Text(contentHeading.subtitle),
            ],
          ),
        ),
      ],
    );
  }
}
