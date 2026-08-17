import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/app_locale.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/send_crash_reports.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/theme_mode.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_animated_graphics.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_custom_accent_color.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_system_theme_color.dart';
import 'package:librelab_flutter/auth/auth_deps_provider.dart';
import 'package:librelab_flutter/auth/login_cubit/login_cubit.dart'
    hide Success;
import 'package:librelab_flutter/auth/ui/login_form_section.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/animated_visual.dart';
import 'package:librelab_flutter/common/ui/widgets/celebration_confetti.dart';
import 'package:librelab_flutter/common/ui/widgets/decorative_icon.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';
import 'package:librelab_flutter/initial_setup/step.dart';
import 'package:librelab_flutter/lab_settings/cubit/lab_settings_cubit.dart';
import 'package:librelab_flutter/lab_settings/lab_settings_deps_provider.dart';
import 'package:librelab_flutter/lab_settings/ui/lab_settings_form.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:librelab_flutter/server_selection/server_selection/ui/server_selection_section.dart';
import 'package:librelab_flutter/server_selection/server_selection_deps_provider.dart';
import 'package:librelab_flutter/user/user_access.dart';
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
            child: ServerSelectionDepsProvider(
              child: LabSettingsDepsProvider(child: _Body()),
            ),
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

    return CelebrationConfetti(
      builder: (context, controller) {
        return StepperFlow(
          currentStepIndex: currentStep.index,
          onStepChanged: (context, i) => context
              .read<InitialSetupCubit>()
              .setStep(InitialSetupStep.values[i]),
          onStepFinished: (context) async {
            controller.play();

            // TODO: Navigate to the next screen (e.g., dashboard screen) and complete
            //  initial setup (i.e., add the user login identity)
            //  bellow is a dummy implementation

            // START: DUMMY_IMPLEMENTATION

            await Future<void>.delayed(const Duration(seconds: 5));

            if (!context.mounted) {
              return;
            }

            final navigator = Navigator.of(context);

            final widget = Directionality(
              textDirection: .ltr,
              child: Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      const Icon(Icons.check_circle_outline, size: 72),
                      const SizedBox(height: 24),
                      Text(
                        'Thank you!',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Thank you for trying this very early build.\nYour feedback helps shape what comes next.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: .center,
                      ),
                    ],
                  ),
                ),
              ),
            );

            navigator.push(
              MaterialPageRoute<void>(builder: (context) => widget),
            );

            // END: DUMMY_IMPLEMENTATION
          },
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
                .complete => LabSettingsForm(
                  hasPermissionToUpdate: UserAccess.fromUser(
                    context.read<LoginCubit>().state.successOrThrow().user,
                  ).can(.labSettingsUpdate),
                ),
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
          canGoTo: _stepCanGoTo(currentStep),
          navigationButtonLabels: NavigationButtonLabels(
            next: t.initialSetupPage.next,
            back: t.initialSetupPage.back,
            finish: t.initialSetupPage.finish,
          ),
        );
      },
    );
  }
}

StepCanGoTo _stepCanGoTo(InitialSetupStep currentStep) => (context, i, mode) {
  final t = context.t.initialSetupPage.steps;

  T watchOrRead<C extends StateStreamable<S>, S, T>(
    T Function(S state) selector,
  ) {
    return switch (mode) {
      .build => context.select((C cubit) => selector(cubit.state)),
      .interaction => selector(context.read<C>().state),
    };
  }

  final isBeyondLastStep = i > InitialSetupStep.values.length - 1;

  if (isBeyondLastStep) {
    final labNameProvided =
        watchOrRead<LabSettingsCubit, LabSettingsState, bool>((s) {
          final fetchState = s.fetchSettingsState;
          if (fetchState is FetchSettingsSuccess) {
            return fetchState.settings.labName != null;
          }
          return false;
        });

    return labNameProvided
        ? const StepFinal()
        : StepDenied(t.complete.prerequisiteStepIncomplete);
  }

  final compatibilityCheckState =
      watchOrRead<
        ServerSelectionCubit,
        ServerSelectionState,
        ServerCompatibilityCheckState
      >((s) => s.compatibilityCheckState);

  final selectedServer =
      watchOrRead<ServerSelectionCubit, ServerSelectionState, SelectedServer?>(
        (s) => s.selectedServer,
      );

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
      t.serverSelection.prerequisiteStepIncomplete,
    ),
    _NotLoggedIn() => StepDenied(t.login.prerequisiteStepIncomplete),
  };
};

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
