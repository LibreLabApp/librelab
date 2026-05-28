import 'package:flutter/material.dart';

part 'horizontal.dart';
part 'vertical.dart';

typedef StepTappedCallback = void Function(int newIndex);

/// Flutter's [Stepper]
/// is [Material 2 widget](https://docs.flutter.dev/ui/widgets/material2)
/// and will be deprecated eventually.
class StepperView extends StatelessWidget {
  const StepperView({
    super.key,
    required this.steps,
    required this.currentStepIndex,
    required this.onStepTapped,
    required this.direction,
    required this.isLocked,
    required this.builder,
  });

  final List<StepNav> steps;
  final int currentStepIndex;
  final StepTappedCallback onStepTapped;

  /// [Axis.horizontal] (mobile / compact):
  /// [1]-[2]-[3]
  /// content below
  ///
  /// [Axis.vertical] (desktop / expanded):
  /// [1]
  /// [2]
  /// [3]   content on the right
  final Axis direction;

  final bool Function(int index) isLocked;
  final Widget Function(int index, Widget child)? builder;

  _StepTileData _stepDataBuilder(int i) {
    final isActive = currentStepIndex == i;
    final isLast = i == steps.length - 1;
    final isComplete = i < currentStepIndex;

    final _StepState stepState = isLocked(i)
        ? .locked
        : isComplete
        ? .complete
        : (isActive ? .active : .inactive);

    final stepNav = steps[i];
    return _StepTileData(
      stepNav: stepNav,
      index: i,
      stepState: stepState,
      isLast: isLast,
      onStepTapped: stepState == .locked ? null : onStepTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (direction) {
      Axis.horizontal => _horizontal(
        theme: Theme.of(context),
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
    final theme = Theme.of(context);
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
      child: () {
        const iconSize = 16.0;
        if (state == .locked) {
          return const Icon(Icons.lock_outline, size: iconSize);
        }
        if (state == .complete) {
          return Icon(Icons.check, size: iconSize, color: colorScheme.primary);
        }
        return Text(
          '${index + 1}',
          style: TextStyle(
            color: state == .active
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        );
      }(),
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
  final StepTappedCallback? onStepTapped;
}

enum _StepState { complete, active, inactive, locked }
