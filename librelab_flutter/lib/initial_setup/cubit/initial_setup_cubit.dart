import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/initial_setup/step.dart';

part 'initial_setup_state.dart';
part 'initial_setup_cubit.freezed.dart';

class InitialSetupCubit extends Cubit<InitialSetupState> {
  InitialSetupCubit() : super(const .initial());

  void setStep(InitialSetupStep step) {
    emit(state.copyWith(currentStep: step));
  }
}
