import 'package:flutter/material.dart' hide Step;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/work_in_progress.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';
import 'package:librelab_flutter/initial_setup/step.dart';
import 'package:librelab_flutter/server_connection/server_selection/server_selection/server_selection_section.dart';
import 'package:librelab_flutter/server_connection/server_selection/server_selection_deps_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:stepper_flow/stepper_flow.dart';

class InitialSetupPage extends StatelessWidget {
  const InitialSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => InitialSetupCubit(),
          child: const ServerSelectionDepsProvider(child: _Body()),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BlocSelector<InitialSetupCubit, InitialSetupState, InitialSetupStep>(
      selector: (state) => state.currentStep,
      builder: (context, currentStep) {
        final cubit = context.read<InitialSetupCubit>();

        return StepperFlow(
          currentStepIndex: currentStep.index,
          onStepChanged: (i) => cubit.setStep(InitialSetupStep.values[i]),
          steps: InitialSetupStep.values.map((e) {
            return Step(
              nav: e.getStepNav(t),
              contentHeading: currentStep.getStepContentHeading(t),
              stepBuilder: (context) => e == .server
                  ? ServerSelectionSection()
                  : const WorkInProgress(),
            );
          }).toList(),
          stepHero: StepHero(
            title: t.initialSetupPage.decorativeAnimation.title,
            subtitle: t.initialSetupPage.decorativeAnimation.subtitle,
            animationWidget: Lottie.asset(
              key: ValueKey(currentStep),
              currentStep.getLottieAsset(),
              height: 100,
              fit: .cover,
            ),
          ),
          canGoTo: (i) {
            final cubit = context.read<InitialSetupCubit>();
            return switch (cubit.canGoTo(InitialSetupStep.values[i])) {
              null => const StepAllowed(),
              ServerNotConfigured() => StepDenied(
                t.initialSetupPage.steps.server.nav.prerequisiteStepIncomplete,
              ),
              AccountSetupNotConfigured() => StepDenied(
                t.initialSetupPage.steps.account.nav.prerequisiteStepIncomplete,
              ),
            };
          },
          navigationButtonLabels: NavigationButtonLabels(
            next: t.initialSetupPage.next,
            back: t.initialSetupPage.back,
          ),
        );
      },
    );
  }
}
