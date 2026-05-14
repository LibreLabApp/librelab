import 'package:flutter/material.dart';
import 'package:librelab_flutter/common/build_context_ext.dart';

part 'horizontal.dart';
part 'vertical.dart';

/// Flutter's [Stepper]
/// is [Material 2 widget](https://docs.flutter.dev/ui/widgets/material2)
/// and will be deprecated eventually.
class StepperView extends StatelessWidget {
  const StepperView({
    super.key,
    required this.steps,
    required this.currentStep,
    required this.onStepTapped,
    required this.direction,
  });

  final List<StepNav> steps;
  final int currentStep;
  final void Function(int newIndex) onStepTapped;

  /// [Axis.horizontal] (mobile / compact):
  /// [1]-[2]-[3]
  /// content below
  ///
  /// [Axis.vertical] (desktop / expanded):
  /// [1]
  /// [2]
  /// [3]   content on the right
  final Axis direction;

  _StepTileData _stepDataBuilder(int i) {
    final isActive = currentStep == i;
    final isLast = i == steps.length - 1;
    final isComplete = i < currentStep;

    final _StepState stepState = isComplete
        ? .complete
        : (isActive ? .active : .inactive);

    final stepNav = steps[i];
    return _StepTileData(
      stepNav: stepNav,
      index: i,
      stepState: stepState,
      isLast: isLast,
      onStepTapped: onStepTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (direction) {
      Axis.horizontal => _horizontal(
        theme: context.theme,
        stepDataBuilder: _stepDataBuilder,
      ),
      Axis.vertical => _vertical(stepDataBuilder: _stepDataBuilder),
    };
  }
}

class _StepIcon extends StatelessWidget {
  const _StepIcon({required this.index, required this.state});

  final int index;
  final _StepState state;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final (textTheme, colorScheme) = (theme.textTheme, theme.colorScheme);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: state == .active
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest,
        shape: .circle,
      ),
      alignment: Alignment.center,
      child: state == .complete
          ? Icon(Icons.check, size: 16, color: colorScheme.primary)
          : Text(
              '${index + 1}',
              style: TextStyle(
                color: state == .active
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
    );
  }
}

@immutable
final class StepNav {
  const StepNav(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

@immutable
class _StepTileData {
  const _StepTileData({
    required this.stepNav,
    required this.index,
    required this.stepState,
    required this.isLast,
    required this.onStepTapped,
  });

  final StepNav stepNav;
  final int index;
  final _StepState stepState;
  final bool isLast;
  final void Function(int newIndex) onStepTapped;
}

enum _StepState { complete, active, inactive }
