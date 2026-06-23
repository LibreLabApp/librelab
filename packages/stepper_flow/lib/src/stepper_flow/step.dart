import 'package:flutter/widgets.dart' show BuildContext, IconData, Widget;
import 'package:meta/meta.dart';
import 'package:stepper_flow/stepper_flow.dart';

typedef StepBuilder = Widget Function(BuildContext context);

@immutable
class const Step({
  required final StepNav nav,
  required final StepContentHeading contentHeading,
  required final StepBuilder stepBuilder,
});

@immutable
class const StepContentHeading({
  required final String title,
  required final String subtitle,
  required final IconData iconData,
});
