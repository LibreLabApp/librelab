import 'package:flutter/widgets.dart' show BuildContext;

enum StepAccessEvaluationMode {
  /// The [BuildContext] is accessed during a widget's `build` method.
  build,

  /// The [BuildContext] is accessed outside a widget's `build` method,
  /// typically during a one-time interaction such as a button press.
  interaction,
}
