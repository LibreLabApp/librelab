part of 'stepper_flow.dart';

/// Displays [_StepProgressIndicator] vertically (medium/large screens)
/// and potentially a Lottie animation at the bottom if available height is sufficient.
class _StepProgressIndicatorSidebar extends StatelessWidget {
  const _StepProgressIndicatorSidebar({
    required this.currentStepIndex,
    required this.onStepChanged,
    required this.steps,
    required this.stepHero,
    required this.canGoTo,
  });

  final int currentStepIndex;
  final StepChangedCallback onStepChanged;
  final List<Step> steps;
  final StepHero stepHero;
  final StepCanGoTo canGoTo;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showDecorativeFooter = constraints.maxHeight > 590;

        return Column(
          children: [
            _StepProgressIndicator(
              direction: .vertical,
              onStepChanged: onStepChanged,
              currentStepIndex: currentStepIndex,
              steps: steps,
              canGoTo: canGoTo,
            ),
            if (showDecorativeFooter)
              ..._decorativeFooter(context: context, stepHero: stepHero),
          ],
        );
      },
    );
  }

  List<Widget> _decorativeFooter({
    required BuildContext context,
    required StepHero stepHero,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return [
      const Spacer(),
      Column(
        children: [
          _DecorativeAnimation(child: stepHero.animationWidget),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 180),
            child: Column(
              children: [
                Text(
                  stepHero.title,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textTheme.displayLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  stepHero.subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: textTheme.bodyLarge?.color?.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 40),
    ];
  }
}

class _DecorativeAnimation extends StatelessWidget {
  const _DecorativeAnimation({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

@immutable
class const StepHero({
  required final String title,
  required final String subtitle,
  required final Widget animationWidget,
});
