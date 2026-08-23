import 'package:flutter/services.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:material_ui/material_ui.dart';

class CopyErrorDetailsSnackBarAction extends SnackBarAction {
  new({
    super.key,
    required BuildContext context,
    required String failureDetails,
  }) : super(
         label: context.t.copyErrorDetails,
         onPressed: () =>
             Clipboard.setData(ClipboardData(text: failureDetails)),
       );
}
