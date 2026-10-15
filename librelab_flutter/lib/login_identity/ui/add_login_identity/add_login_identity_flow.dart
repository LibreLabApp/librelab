import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/app_locale.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/custom_accent_color.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/font_size.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/send_crash_reports.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/theme_mode.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_animated_graphics.dart';
import 'package:librelab_flutter/app_settings/ui/tiles/use_system_theme_color.dart';
import 'package:librelab_flutter/auth/login_cubit/login_cubit.dart'
    hide Success;
import 'package:librelab_flutter/auth/ui/login_form_section.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/animated_visual.dart';
import 'package:librelab_flutter/common/ui/widgets/decorative_icon.dart';
import 'package:librelab_flutter/common/ui/widgets/failure/show_technical_failure_details_snack_bar_action.dart';
import 'package:librelab_flutter/common/ui/widgets/illustrations/gears.dart';
import 'package:librelab_flutter/generated/assets.gen.dart' show Assets;
import 'package:librelab_flutter/lab_settings/cubit/lab_settings_cubit.dart';
import 'package:librelab_flutter/lab_settings/lab_settings_deps_provider.dart';
import 'package:librelab_flutter/lab_settings/ui/lab_settings_form.dart';
import 'package:librelab_flutter/login_identity/cubit/login_identity_cubit.dart';
import 'package:librelab_flutter/login_identity/ui/add_login_identity/add_login_identity_step.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:librelab_flutter/server_selection/server_selection/ui/server_selection_section.dart';
import 'package:librelab_flutter/server_selection/server_selection_deps_provider.dart';
import 'package:librelab_flutter/user/user_access.dart';
import 'package:lottie/lottie.dart';
import 'package:material_ui/material_ui.dart' hide Step;
import 'package:provider/provider.dart';
import 'package:stepper_flow/stepper_flow.dart';

class const AddLoginIdentityFlow({
  super.key,
  required final AddLoginIdentityStep _startingStep,
  final void Function()? onCompleted,
}) extends StatefulWidget {
  @override
  State<AddLoginIdentityFlow> createState() => _AddLoginIdentityFlowState();
}

class _AddLoginIdentityFlowState extends State<AddLoginIdentityFlow> {
  late AddLoginIdentityStep _currentStep = widget._startingStep;

  void _setStep(AddLoginIdentityStep newStep) =>
      setState(() => _currentStep = newStep);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [
        ServerSelectionDepsProvider(),
        LabSettingsDepsProvider(),
      ],
      child: _LoginIdentityFailureListener(child: _buildFlow()),
    );
  }

  Widget _buildFlow() {
    final rootT = context.t;
    final t = rootT.addLoginIdentityFlow;

    return StepperFlow(
      currentStepIndex: _currentStep.index,
      onStepChanged: (context, i) => _setStep(AddLoginIdentityStep.values[i]),
      onFinished: (context) async {
        final serverBaseUrl = context
            .read<ServerSelectionCubit>()
            .state
            .serverUriOrThrow();

        final loginSuccessResult = context
            .read<LoginCubit>()
            .state
            .successOrThrow();

        final labName = context
            .read<LabSettingsCubit>()
            .state
            .labSettingsOrThrow()
            .labName;

        if (labName == null) {
          throw StateError(
            'Lab name must be provided before completing the setup',
          );
        }

        final scaffoldMessenger = context.scaffoldMessenger;

        final loginCubit = context.read<LoginCubit>();

        await context.read<LoginIdentityCubit>().completeLogin(
          serverBaseUrl: serverBaseUrl,
          labName: labName,
          user: loginSuccessResult.result.user,
          authSession: loginSuccessResult.result.authSession,
          persistAuthSession: loginSuccessResult.persistAuthSession,
          onCompleted: (result) {
            // Resets the temporary login state after completing the login flow.
            loginCubit.resetState();

            widget.onCompleted?.call();

            final name = result.loginIdentity.user.fullName;
            scaffoldMessenger.showSnackBarMessage(
              result.isNew
                  ? t.finishSuccess.addedNewLoginIdentity(name: name)
                  : t.finishSuccess.updatedExistingLoginIdentity(name: name),
            );
          },
        );
      },
      isFinishing: (context) {
        return context.select(
          (LoginIdentityCubit v) => v.state.loadState.isLoading,
        );
      },
      steps: AddLoginIdentityStep.values.map((step) {
        return Step(
          nav: step.getStepNav(rootT),
          contentHeading: _currentStep.getStepContentHeading(rootT),
          stepBuilder: (context) => switch (step) {
            .preferences => const Column(
              spacing: 16,
              children: [
                AppLocaleListTile(),
                ThemeModeListTile(),
                UseSystemThemeColorListTile(),
                CustomAccentColorListTile(),
                FontSizeListTile(),
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
                context.read<LoginCubit>().state.successOrThrow().result.user,
              ).can(.labSettingsUpdate),
            ),
          },
        );
      }).toList(),
      stepHero: StepHero(
        title: t.decorativeAnimation.title,
        subtitle: t.decorativeAnimation.subtitle,
        animationWidget: AnimatedVisual(
          key: ValueKey(_currentStep),
          animated: (context) {
            LottieBuilder lottie(
              String assetPath,

              LottieDelegates? delegates,
            ) => Lottie.asset(
              assetPath,
              height: 100,
              fit: .cover,
              delegates: delegates,
            );

            // TODO: Update all Lottie assets to adapt to the app theme

            return switch (_currentStep) {
              AddLoginIdentityStep.preferences => const GearsIllustration(
                size: 120,
              ),
              .serverSelection => lottie(Assets.lottie.server, null),
              .login => lottie(Assets.lottie.account, null),
              .complete => lottie(Assets.lottie.rocket, null),
            };
          },
          fallback: (context) => DecorativeIcon(_currentStep.getIcon()),
        ),
      ),
      canGoTo: _stepCanGoTo(_currentStep),
      navigationButtonLabels: NavigationButtonLabels(
        next: t.next,
        back: t.back,
        finish: t.finish,
      ),
    );
  }
}

StepCanGoTo _stepCanGoTo(
  AddLoginIdentityStep currentStep,
) => (context, i, mode) {
  final t = context.t.addLoginIdentityFlow.steps;

  T watchOrRead<C extends StateStreamable<S>, S, T>(
    T Function(S state) selector,
  ) {
    return switch (mode) {
      .build => context.select((C cubit) => selector(cubit.state)),
      .interaction => selector(context.read<C>().state),
    };
  }

  final isBeyondLastStep = i > AddLoginIdentityStep.values.length - 1;

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
    targetStep: AddLoginIdentityStep.values[i],
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
  required AddLoginIdentityStep targetStep,
  required AddLoginIdentityStep currentStep,
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

/// Shows a snackbar when finishing the flow fails.
class const _LoginIdentityFailureListener({required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Refactor to use CubitEffect and CubitEffectListener
    return BlocListener<LoginIdentityCubit, LoginIdentityState>(
      listenWhen: (previous, current) =>
          previous.loadState.failureOrNull != current.loadState.failureOrNull,
      listener: (context, state) {
        final failureDetails = state.loadState.failureOrNull;

        if (failureDetails != null) {
          final t = context.t;

          context.showSnackBarMessage(
            t.addLoginIdentityFlow.finishFailure,
            action: ShowTechnicalFailureDetailsSnackBarAction(
              context: context,
              failureDetails: failureDetails,
            ),
          );
        }
      },
      child: child,
    );
  }
}
