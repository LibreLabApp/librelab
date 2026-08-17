import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/common/ui/api_request_failure_ui_messages.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/alert_card.dart';
import 'package:material_ui/material_ui.dart';

class const ApiRequestFailureCard({
  super.key,
  required final String title,
  required final ApiRequestFailure failure,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertCard(
      type: .error,
      prefixIcon: Icons.error_outline_rounded,
      suffix: null,
      title: Text(title),
      subtitle: Tooltip(
        constraints: const .new(maxWidth: 300),
        message: failure.message,
        child: Text(failure.getUiMessage(context.t)),
      ),
    );
  }
}
