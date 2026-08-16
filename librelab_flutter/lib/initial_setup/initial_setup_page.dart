import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/app_locale.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/send_crash_reports.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/theme_mode.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_animated_graphics.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_custom_accent_color.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_system_theme_color.dart';
import 'package:librelab_flutter/auth/auth_deps_provider.dart';
import 'package:librelab_flutter/auth/cubit/login_cubit.dart' hide Success;
import 'package:librelab_flutter/auth/ui/login_form_section.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/animated_visual.dart';
import 'package:librelab_flutter/common/ui/widgets/decorative_icon.dart';
import 'package:librelab_flutter/common/ui/widgets/work_in_progress.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';
import 'package:librelab_flutter/initial_setup/step.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:librelab_flutter/server_selection/server_selection/ui/server_selection_section.dart';
import 'package:librelab_flutter/server_selection/server_selection_deps_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:material_ui/material_ui.dart' hide Step;
import 'package:stepper_flow/stepper_flow.dart';

class const InitialSetupPage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => InitialSetupCubit(),
          child: const AuthDepsProvider(
            child: ServerSelectionDepsProvider(child: _Body()),
          ),
        ),
      ),
    );
  }
}

class const _Body() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = context.t;

    final currentStep = context.select(
      (InitialSetupCubit v) => v.state.currentStep,
    );

    return StepperFlow(
      currentStepIndex: currentStep.index,
      onStepChanged: (context, i) =>
          context.read<InitialSetupCubit>().setStep(InitialSetupStep.values[i]),
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
                if (AnimatedVisual.supported) UseAnimatedGraphicsListTile(),
                SendCrashReportsListTile(),
              ],
            ),
            .serverSelection => const ServerSelectionSection(),
            .login => LoginFormSection(
              serverBaseUrl: context
                  .read<ServerSelectionCubit>()
                  .state
                  .serverUriOrThrow(),
            ),
            .complete => const WorkInProgress(),
          },
        );
      }).toList(),
      stepHero: StepHero(
        title: t.initialSetupPage.decorativeAnimation.title,
        subtitle: t.initialSetupPage.decorativeAnimation.subtitle,
        animationWidget: AnimatedVisual(
          key: ValueKey(currentStep),
          animated: (context) => Lottie.asset(
            currentStep.getLottieAsset(),
            height: 100,
            fit: .cover,
          ),
          fallback: (context) => DecorativeIcon(currentStep.getIcon()),
        ),
      ),
      canGoTo: (context, i, mode) {
        final t = context.t.initialSetupPage.steps;

        if (i > InitialSetupStep.values.length - 1) {
          // TODO: Fix this limitation in the stepper_flow package.
          //  This if-check workaround should not be needed.
          return const StepDenied('This is the final step');
        }

        T watchOrRead<C extends StateStreamable<S>, S, T>(
          T Function(S state) selector,
        ) {
          return switch (mode) {
            .build => context.select((C cubit) => selector(cubit.state)),
            .interaction => selector(context.read<C>().state),
          };
        }

        final compatibilityCheckState =
            watchOrRead<
              ServerSelectionCubit,
              ServerSelectionState,
              ServerCompatibilityCheckState
            >((s) => s.compatibilityCheckState);

        final selectedServer =
            watchOrRead<
              ServerSelectionCubit,
              ServerSelectionState,
              SelectedServer?
            >((s) => s.selectedServer);

        final isLoginSuccessful = watchOrRead<LoginCubit, LoginState, bool>(
          (s) => s.isSuccess,
        );

        final canGoResult = _canGoTo(
          targetStep: InitialSetupStep.values[i],
          currentStep: currentStep,
          compatibilityCheckState: compatibilityCheckState,
          selectedServer: selectedServer,
          isLoginSuccessful: isLoginSuccessful,
        );
        return switch (canGoResult) {
          null => const StepAllowed(),
          _ServerNotConfigured() => StepDenied(
            t.serverSelection.nav.prerequisiteStepIncomplete,
          ),
          _NotLoggedIn() => StepDenied(t.login.nav.prerequisiteStepIncomplete),
        };
      },
      navigationButtonLabels: NavigationButtonLabels(
        next: t.initialSetupPage.next,
        back: t.initialSetupPage.back,
      ),
    );
  }
}

_StepAccessDeniedReason? _canGoTo({
  required InitialSetupStep targetStep,
  required InitialSetupStep currentStep,
  required ServerCompatibilityCheckState compatibilityCheckState,
  required SelectedServer? selectedServer,
  required bool isLoginSuccessful,
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
    .complete =>
      canGoToLogin
          ? (isLoginSuccessful ? null : const _NotLoggedIn())
          : const _NotLoggedIn(),
  };
}

@immutable
sealed class const _StepAccessDeniedReason();

final class const _ServerNotConfigured() extends _StepAccessDeniedReason;

final class const _NotLoggedIn() extends _StepAccessDeniedReason;
