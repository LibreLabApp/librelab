import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/common/ui/api_request_failure_ui_messages.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:material_ui/material_ui.dart';

class const ApiRequestFailureView({
  super.key,
  required final String title,
  required final ApiRequestFailure failure,
  required final VoidCallback onRetry,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final (colorScheme, textTheme) = (theme.colorScheme, theme.textTheme);

    final t = context.t;

    return Center(
      child: ConstrainedBox(
        constraints: const .new(maxWidth: 420),
        child: Padding(
          padding: const .all(24),
          child: Column(
            mainAxisSize: .min,
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: 40,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(title, style: textTheme.titleLarge, textAlign: .center),
              const SizedBox(height: 8),
              Text(
                failure.getUiMessage(t),
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: .center,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(t.retry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
