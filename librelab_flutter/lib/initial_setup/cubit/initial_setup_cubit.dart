import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/initial_setup/step.dart';

part 'initial_setup_state.dart';
part 'initial_setup_cubit.freezed.dart';

class InitialSetupCubit extends Cubit<InitialSetupState> {
  InitialSetupCubit()
    : super(
        const InitialSetupState(
          currentStep: InitialSetupStep.preferences,
          // TODO: Maybe disable the button by default with no tooltp and then allow steps to enable it manually?
          nextButtonDisabledTooltip: null,
        ),
      );

  void setStep(InitialSetupStep step) {
    emit(state.copyWith(currentStep: step));
  }

  void moveStep({required bool forward}) {
    final newIndex = state.currentStep.index + (forward ? 1 : -1);
    if (newIndex == -1) {
      return;
    }
    final newStep = InitialSetupStep.values.elementAtOrNull(newIndex);
    if (newStep == null) {
      return;
    }
    setStep(newStep);
  }

  bool canGoTo(InitialSetupStep targetStep) {
    final isForward = targetStep.index > state.currentStep.index;
    if (!isForward) {
      return true;
    }

    return switch (targetStep) {
      InitialSetupStep.preferences => true,
      InitialSetupStep.server => true,
      // TODO: (Account validation) Server URL must not be null & connection test must succeed for that URL
      InitialSetupStep.account => canGoTo(.server),
      // TODO: (Complete validation) Email / password fields must not be null & login credentials are valid
      InitialSetupStep.complete => canGoTo(.account),
    };
  }

  void setServerUrl(String serverUrl) {
    emit(state.copyWith(serverUrl: serverUrl));
  }
}
