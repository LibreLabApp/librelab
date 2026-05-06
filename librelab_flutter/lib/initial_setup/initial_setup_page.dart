import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/build_context_ext.dart';
import 'package:librelab_flutter/common/stepper_view.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';
import 'package:librelab_flutter/initial_setup/pager.dart';
import 'package:librelab_flutter/initial_setup/step.dart';
import 'package:lottie/lottie.dart';

class InitialSetupPage extends StatelessWidget {
  const InitialSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => InitialSetupCubit(),
        child: const Row(
          spacing: 24,
          children: [
            SizedBox(
              width: 220,
              child: Padding(
                padding: EdgeInsets.only(top: 24, left: 16),
                child: _LeftSide(),
              ),
            ),
            Expanded(
              child: Card(margin: .zero, child: _RightSide()),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeftSide extends StatelessWidget {
  const _LeftSide();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Column(
      children: [
        BlocSelector<InitialSetupCubit, InitialSetupState, InitialSetupStep>(
          selector: (state) => state.currentStep,
          builder: (context, currentStep) {
            return StepperView(
              currentStep: currentStep.index,
              // TODO: Prevent user from moving to the next step without finishing the current!
              onStepTapped: (index) => context
                  .read<InitialSetupCubit>()
                  .setStep(InitialSetupStep.values.elementAt(index)),
              steps: InitialSetupStep.values
                  .map((e) => e.getStepData(context.t))
                  .toList(),
            );
          },
        ),
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
                    'Almost there!',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textTheme.displayLarge?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Let's get everything setup for you",
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
      ],
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

class _RightSide extends StatelessWidget {
  const _RightSide();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            spacing: 24,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                child: const Icon(Icons.link),
              ),
              Column(
                crossAxisAlignment: .start,
                spacing: 6,
                children: [
                  // TODO: Change based on current step
                  Text(
                    'Server Configuration',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: .bold,
                    ),
                  ),
                  const Text('Enter the server details to get started.'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Expanded(child: InitialSetupPager()),
        ],
      ),
    );
  }
}
