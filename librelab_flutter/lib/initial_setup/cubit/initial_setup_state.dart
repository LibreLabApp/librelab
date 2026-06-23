// ignore_for_file: annotate_overrides

part of 'initial_setup_cubit.dart';

@immutable
@freezed
class const InitialSetupState({required final InitialSetupStep currentStep})
    with _$InitialSetupState {
  /// The initial state of the initial setup page
  factory initialState() => const InitialSetupState(currentStep: .preferences);
}
