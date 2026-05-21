import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/stepper_view/stepper_view.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';
import 'package:librelab_flutter/initial_setup/pager.dart';
import 'package:librelab_flutter/initial_setup/step.dart';
import 'package:lottie/lottie.dart';

class InitialSetupPage extends StatelessWidget {
  const InitialSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => InitialSetupCubit(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final usesSidebar = constraints.maxWidth >= 710;
              final Axis direction = usesSidebar ? .horizontal : .vertical;

              return Flex(
                direction: direction,
                spacing: 24,
                children: [
                  SizedBox(
                    width: direction == .horizontal ? 220 : null,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24, left: 16),
                      child: usesSidebar
                          ? const _StepProgressIndicatorSidebar()
                          : const _StepProgressIndicator(
                              direction: .horizontal,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      margin: .zero,
                      child: _CurrentStepContent(usesSidebar: usesSidebar),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StepProgressIndicator extends StatelessWidget {
  const _StepProgressIndicator({required this.direction});

  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InitialSetupCubit, InitialSetupState, InitialSetupStep>(
      selector: (state) => state.currentStep,
      builder: (context, currentStep) {
        return StepperView(
          direction: direction,
          currentStep: currentStep.index,
          // TODO: Prevent user from moving to the next step without finishing the current!
          onStepTapped: (index) => context.read<InitialSetupCubit>().setStep(
            InitialSetupStep.values.elementAt(index),
          ),
          steps: InitialSetupStep.values
              .map((e) => e.getStepNav(context.t))
              .toList(),
        );
      },
    );
  }
}

/// Displays [_StepProgressIndicator] vertically (medium/large screens)
/// and potentially a Lottie animation at the bottom if available height is sufficient.
class _StepProgressIndicatorSidebar extends StatelessWidget {
  const _StepProgressIndicatorSidebar();

  List<Widget> _footerHero({required BuildContext context}) {
    final (t, textTheme, theme) = (
      context.t.initialSetupPage.decorativeAnimation,
      context.theme.textTheme,
      context.theme,
    );

    return [
      const Spacer(),
      Column(
        children: [
          const _LottieAnimation(),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 180),
            child: Column(
              children: [
                Text(
                  t.title,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textTheme.displayLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  t.subtitle,
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showFooterHero = constraints.maxHeight > 590;

        return Column(
          children: [
            const _StepProgressIndicator(direction: .vertical),
            if (showFooterHero) ..._footerHero(context: context),
          ],
        );
      },
    );
  }
}

class _LottieAnimation extends StatelessWidget {
  const _LottieAnimation();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<InitialSetupCubit, InitialSetupState, InitialSetupStep>(
      selector: (state) => state.currentStep,
      builder: (context, step) => AnimatedSwitcher(
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
        child: Lottie.asset(
          key: ValueKey(step),
          step.getLottieAsset(),
          height: 100,
          fit: .cover,
        ),
      ),
    );
  }
}

class _CurrentStepContent extends StatelessWidget {
  const _CurrentStepContent({required this.usesSidebar});

  final bool usesSidebar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const _StepContentHeading(),
          const SizedBox(height: 32),
          Expanded(child: InitialSetupPager(usesSidebar: usesSidebar)),
        ],
      ),
    );
  }
}

class _StepContentHeading extends StatelessWidget {
  const _StepContentHeading();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final currentStep = context.select(
      (InitialSetupCubit v) => v.state.currentStep,
    );

    final stepContentHeading = currentStep.getStepContentHeading(context.t);

    return Row(
      spacing: 24,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          child: Icon(stepContentHeading.iconData),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 6,
            children: [
              Text(
                stepContentHeading.title,
                style: textTheme.headlineMedium?.copyWith(fontWeight: .bold),
              ),
              Text(stepContentHeading.subtitle),
            ],
          ),
        ),
      ],
    );
  }
}
