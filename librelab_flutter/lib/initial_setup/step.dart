import 'package:librelab_flutter/common/stepper_view.dart';
import 'package:librelab_flutter/generated/assets.gen.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart';

enum InitialSetupStep {
  preferences,
  server,
  account,
  complete;

  InitialSetupStep get next => values[index + 1];
  InitialSetupStep get previous => values[index - 1];
  bool get isLast => index == values.length - 1;
}

extension InitialSetupStepExt on InitialSetupStep {
  StepData getStepData(Translations t) {
    final steps = t.initialSetupPage.steps;
    final title = switch (this) {
      InitialSetupStep.preferences => steps.preferences.title,
      InitialSetupStep.server => steps.server.title,
      InitialSetupStep.account => steps.account.title,
      InitialSetupStep.complete => steps.complete.title,
    };
    final subtitle = switch (this) {
      InitialSetupStep.preferences => steps.preferences.subtitle,
      InitialSetupStep.server => steps.server.subtitle,
      InitialSetupStep.account => steps.account.subtitle,
      InitialSetupStep.complete => steps.complete.subtitle,
    };
    return StepData(title, subtitle);
  }

  String getLottieAsset() {
    return switch (this) {
      InitialSetupStep.preferences => Assets.lottie.settings,
      InitialSetupStep.server => Assets.lottie.server,
      InitialSetupStep.account => Assets.lottie.account,
      InitialSetupStep.complete => Assets.lottie.rocket,
    }.path;
  }
}
