part of 'initial_setup_cubit.dart';

@immutable
@freezed
final class InitialSetupState with _$InitialSetupState {
  const InitialSetupState({required this.currentStep});

  /// The initial state of the initial setup page
  factory InitialSetupState.initialState() =>
      const InitialSetupState(currentStep: .preferences);

  @override
  final InitialSetupStep currentStep;
}
