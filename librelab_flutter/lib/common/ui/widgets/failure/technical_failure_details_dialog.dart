import 'package:go_router/go_router.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/copy_code_block.dart';
import 'package:material_ui/material_ui.dart';

/// Dialog to show technical details for unclear or expected failures.
///
/// This is not meant for bugs or unexpected programming errors; the app should always avoid
/// handling these.
class const TechnicalFailureDetailsDialog({
  super.key,
  required final String details,
}) extends StatelessWidget {
  static void show(BuildContext context, {required String details}) =>
      showDialog<void>(
        context: context,
        builder: (context) => TechnicalFailureDetailsDialog(details: details),
      );

  @override
  Widget build(BuildContext context) {
    final t = context.t.technicalFailureDetails.dialog;

    return AlertDialog(
      title: Text(t.title),
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const .only(bottom: 8.0),
            child: Text(t.description, style: const TextStyle(fontSize: 14)),
          ),
          CopyCodeBlock(code: details),
        ],
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(context.ml.closeButtonLabel),
        ),
      ],
    );
  }
}
