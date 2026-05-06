part of 'initial_setup_cubit.dart';

@immutable
@freezed
final class InitialSetupState with _$InitialSetupState {
  const InitialSetupState({
    required this.currentStep,
    required this.nextButtonDisabledTooltip,
    this.serverUrl,
  });

  @override
  final InitialSetupStep currentStep;

  /// A non-null value indicates the `Next` button is disabled, and this `String`
  /// will be used as a tooltip when hovering over the button.
  ///
  /// Set this to `null` to activate the button.
  @override
  final String? nextButtonDisabledTooltip;

  @override
  final String? serverUrl;
}
