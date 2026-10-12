import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/failure/technical_failure_details_dialog.dart';
import 'package:material_ui/material_ui.dart';

class const FailureView({
  super.key,
  required final String message,
  required final VoidCallback onRetry,
  required final String technicalDetails,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final textTheme = context.theme.textTheme;

    return Column(
      mainAxisSize: .min,
      children: [
        Text(message, style: textTheme.bodyMedium, textAlign: .center),
        TextButton(onPressed: onRetry, child: Text(t.retry)),
        TextButton(
          onPressed: () => TechnicalFailureDetailsDialog.show(
            context,
            details: technicalDetails,
          ),
          child: Text(t.technicalFailureDetails.showDialog),
        ),
      ],
    );
  }
}
