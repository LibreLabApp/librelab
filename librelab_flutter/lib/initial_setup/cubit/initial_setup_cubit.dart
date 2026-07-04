import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/initial_setup/step.dart';

part 'initial_setup_state.dart';
part 'initial_setup_cubit.freezed.dart';

@immutable
sealed class const StepAccessDeniedReason();

final class const ServerNotConfigured() extends StepAccessDeniedReason;

final class const AccountSetupNotConfigured() extends StepAccessDeniedReason;

class InitialSetupCubit extends Cubit<InitialSetupState> {
  InitialSetupCubit() : super(const .initialState());

  void setStep(InitialSetupStep step) {
    emit(state.copyWith(currentStep: step));
  }

  StepAccessDeniedReason? canGoTo(InitialSetupStep targetStep) {
    final isForward = targetStep.index > state.currentStep.index;
    if (!isForward) {
      return null;
    }

    return switch (targetStep) {
      .preferences => null,
      .serverSelection => null,
      // TODO: (Account validation) Server URL must not be null & connection test must succeed for that URL
      .login => const ServerNotConfigured(),
      // TODO: (Complete validation) Email / password fields must not be null & login credentials are valid
      .complete => canGoTo(.login) ?? const AccountSetupNotConfigured(),
    };
  }
}
