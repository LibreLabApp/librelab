import 'package:flutter/widgets.dart' show BuildContext, IconData, Widget;
import 'package:meta/meta.dart';
import 'package:stepper_flow/stepper_flow.dart';

typedef StepBuilder = Widget Function(BuildContext context);

@immutable
class Step {
  const Step({
    required this.nav,
    required this.contentHeading,
    required this.stepBuilder,
  });

  final StepNav nav;
  final StepContentHeading contentHeading;
  final StepBuilder stepBuilder;
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
