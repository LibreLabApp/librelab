import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/generated/assets.gen.dart';
import 'package:stepper_flow/stepper_flow.dart';

enum InitialSetupStep {
  /// Allows configuring preferences such as the theme mode,
  /// language, and other application settings.
  preferences,

  /// Allows selecting the server instance that the application
  /// should use, including validating connectivity and compatibility.
  serverSelection,

  /// Allows logging in with an email address and password.
  login,

  /// Final step of the setup process. May require completing
  /// the initial laboratory configuration if it has not
  /// already been completed.
  complete;

  InitialSetupStep get next => values[index + 1];
  InitialSetupStep get previous => values[index - 1];
  bool get isLast => index == values.length - 1;
}

extension InitialSetupStepExt on InitialSetupStep {
  StepNav getStepNav(Translations t) {
    final steps = t.initialSetupPage.steps;
    final title = switch (this) {
      .preferences => steps.preferences.nav.title,
      .serverSelection => steps.serverSelection.nav.title,
      .login => steps.login.nav.title,
      .complete => steps.complete.nav.title,
    };
    final subtitle = switch (this) {
      .preferences => steps.preferences.nav.subtitle,
      .serverSelection => steps.serverSelection.nav.subtitle,
      .login => steps.login.nav.subtitle,
      .complete => steps.complete.nav.subtitle,
    };
    return .new(title, subtitle);
  }

  String getLottieAsset() {
    return switch (this) {
      .preferences => Assets.lottie.settings,
      .serverSelection => Assets.lottie.server,
      .login => Assets.lottie.account,
      .complete => Assets.lottie.rocket,
    };
  }

  IconData getIcon() {
    return switch (this) {
      .preferences => Icons.tune_rounded,
      .serverSelection => Icons.dns_rounded,
      .login => Icons.login_rounded,
      .complete => Icons.check_circle_rounded,
    };
  }

  StepContentHeading getStepContentHeading(Translations t) {
    final steps = t.initialSetupPage.steps;
    final title = switch (this) {
      .preferences => steps.preferences.content.title,
      .serverSelection => steps.serverSelection.content.title,
      .login => steps.login.content.title,
      .complete => steps.complete.content.title,
    };
    final subtitle = switch (this) {
      .preferences => steps.preferences.content.subtitle,
      .serverSelection => steps.serverSelection.content.subtitle,
      .login => steps.login.content.subtitle,
      .complete => steps.complete.content.subtitle,
    };
    final iconData = switch (this) {
      .preferences => Icons.tune,
      .serverSelection => Icons.link,
      .login => Icons.account_circle,
      .complete => Icons.check,
    };

    return .new(title: title, subtitle: subtitle, iconData: iconData);
  }
}
