import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart' show IconData;
import 'package:librelab_flutter/common/stepper_view/stepper_view.dart';
import 'package:librelab_flutter/generated/assets.gen.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart';
import 'package:meta/meta.dart';

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
  StepNav getStepNav(Translations t) {
    final steps = t.initialSetupPage.steps;
    final title = switch (this) {
      InitialSetupStep.preferences => steps.preferences.nav.title,
      InitialSetupStep.server => steps.server.nav.title,
      InitialSetupStep.account => steps.account.nav.title,
      InitialSetupStep.complete => steps.complete.nav.title,
    };
    final subtitle = switch (this) {
      InitialSetupStep.preferences => steps.preferences.nav.subtitle,
      InitialSetupStep.server => steps.server.nav.subtitle,
      InitialSetupStep.account => steps.account.nav.subtitle,
      InitialSetupStep.complete => steps.complete.nav.subtitle,
    };
    return StepNav(title, subtitle);
  }

  String getLottieAsset() {
    return switch (this) {
      InitialSetupStep.preferences => Assets.lottie.settings,
      InitialSetupStep.server => Assets.lottie.server,
      InitialSetupStep.account => Assets.lottie.account,
      InitialSetupStep.complete => Assets.lottie.rocket,
    }.path;
  }

  StepContentHeading getStepContentHeading(Translations t) {
    final steps = t.initialSetupPage.steps;
    final title = switch (this) {
      InitialSetupStep.preferences => steps.preferences.content.title,
      InitialSetupStep.server => steps.server.content.title,
      InitialSetupStep.account => steps.account.content.title,
      InitialSetupStep.complete => steps.complete.content.title,
    };
    final subtitle = switch (this) {
      InitialSetupStep.preferences => steps.preferences.content.subtitle,
      InitialSetupStep.server => steps.server.content.subtitle,
      InitialSetupStep.account => steps.account.content.subtitle,
      InitialSetupStep.complete => steps.complete.content.subtitle,
    };
    final iconData = switch (this) {
      InitialSetupStep.preferences => Icons.tune,
      InitialSetupStep.server => Icons.link,
      InitialSetupStep.account => Icons.account_circle,
      InitialSetupStep.complete => Icons.check,
    };

    return StepContentHeading(
      title: title,
      subtitle: subtitle,
      iconData: iconData,
    );
  }
}

@immutable
class StepContentHeading {
  const StepContentHeading({
    required this.title,
    required this.subtitle,
    required this.iconData,
  });

  final String title;
  final String subtitle;
  final IconData iconData;
}
