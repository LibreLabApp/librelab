/// @docImport 'package:librelab_flutter/initial_setup/initial_setup_page.dart';
/// @docImport 'package:librelab_flutter/login_identity/ui/add_login_identity/add_login_identity_flow.dart';
library;

import 'package:flutter/widgets.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:material_ui/material_ui.dart' show Icons;
import 'package:stepper_flow/stepper_flow.dart';

enum AddLoginIdentityStep {
  /// Allows configuring preferences such as the theme mode,
  /// language, and other application settings.
  ///
  /// NOTE: This step is not part of adding a login identity. It is included here
  /// as a temporary architectural compromise so [AddLoginIdentityFlow] can
  /// also be reused by the [InitialSetupPage]. This is accepted technical
  /// debt and does not materially affect the user-facing flow.
  preferences,

  /// Prompts the user to select the server instance to use, then validates
  /// its connectivity and compatibility.
  serverSelection,

  /// Prompts the user to log in with an email address and password.
  login,

  /// Final step of the flow. May require providing laboratory information
  /// if it has not already been provided.
  complete;

  AddLoginIdentityStep get next => values[index + 1];
  AddLoginIdentityStep get previous => values[index - 1];

  bool get isLast => index == values.length - 1;
}

extension InitialSetupStepExt on AddLoginIdentityStep {
  StepNav getStepNav(Translations t) {
    final steps = t.addLoginIdentityFlow.steps;
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

  IconData getIcon() {
    return switch (this) {
      .preferences => Icons.tune_rounded,
      .serverSelection => Icons.dns_rounded,
      .login => Icons.login_rounded,
      .complete => Icons.check_circle_rounded,
    };
  }

  StepContentHeading getStepContentHeading(Translations t) {
    final steps = t.addLoginIdentityFlow.steps;
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
