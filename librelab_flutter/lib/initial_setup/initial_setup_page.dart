import 'package:flutter/material.dart' hide Step;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/app_locale.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/send_crash_reports.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/theme_mode.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_custom_accent_color.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_system_theme_color.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/work_in_progress.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';
import 'package:librelab_flutter/initial_setup/step.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:librelab_flutter/server_selection/server_selection/server_selection_section.dart';
import 'package:librelab_flutter/server_selection/server_selection_deps_provider.dart';
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

    return Builder(
      builder: (context) {
        final currentStep = context.select(
          (InitialSetupCubit v) => v.state.currentStep,
        );

        // TODO: Move compatibilityCheckState and selectedServer inside canGoTo() once it accepts a BuildContext
        final compatibilityCheckState = context.select(
          (ServerSelectionCubit v) => v.state.compatibilityCheckState,
        );
        // TODO: Bad and must be avoided (causing issues when editing the TextField in "Enter Server Address")
        final selectedServer = context.select(
          (ServerSelectionCubit v) => v.state.selectedServer,
        );

        return StepperFlow(
          currentStepIndex: currentStep.index,
          onStepChanged: (i) => context.read<InitialSetupCubit>().setStep(
            InitialSetupStep.values[i],
          ),
          steps: InitialSetupStep.values.map((e) {
            return Step(
              nav: e.getStepNav(t),
              contentHeading: currentStep.getStepContentHeading(t),
              stepBuilder: (context) => switch (e) {
                .preferences => const Column(
                  spacing: 16,
                  children: [
                    AppLocaleListTile(),
                    ThemeModeListTile(),
                    UseSystemThemeColorListTile(),
                    UseCustomAccentColorListTile(),
                    SendCrashReportsListTile(),
                  ],
                ),
                .serverSelection => ServerSelectionSection(),
                .login => const WorkInProgress(),
                .complete => const WorkInProgress(),
              },
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
            final t = context.t.initialSetupPage.steps;

            if (i > InitialSetupStep.values.length - 1) {
              // TODO: Fix this limitation in the stepper_flow package.
              //  This if-check workaround should not be needed.
              return const StepDenied('This is the final step');
            }

            final canGoResult = _canGoTo(
              targetStep: InitialSetupStep.values[i],
              currentStep: currentStep,
              compatibilityCheckState: compatibilityCheckState,
              selectedServer: selectedServer,
            );
            return switch (canGoResult) {
              null => const StepAllowed(),
              _ServerNotConfigured() => StepDenied(
                t.serverSelection.nav.prerequisiteStepIncomplete,
              ),
              _AccountSetupNotConfigured() => StepDenied(
                t.login.nav.prerequisiteStepIncomplete,
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

_StepAccessDeniedReason? _canGoTo({
  required InitialSetupStep targetStep,
  required InitialSetupStep currentStep,
  required ServerCompatibilityCheckState compatibilityCheckState,
  required SelectedServer? selectedServer,
}) {
  final isForward = targetStep.index > currentStep.index;
  if (!isForward) {
    return null;
  }

  final canGoToLogin =
      compatibilityCheckState is Success &&
      compatibilityCheckState.server == selectedServer &&
      compatibilityCheckState.response.status.isCompatible;

  return switch (targetStep) {
    .preferences => null,
    .serverSelection => null,
    .login => canGoToLogin ? null : const _ServerNotConfigured(),
    // TODO: (Complete validation) Email / password fields must not be null & login credentials are valid
    .complete => canGoToLogin ? null : const _AccountSetupNotConfigured(),
  };
}

@immutable
sealed class const _StepAccessDeniedReason();

final class const _ServerNotConfigured() extends _StepAccessDeniedReason;

final class const _AccountSetupNotConfigured() extends _StepAccessDeniedReason;
