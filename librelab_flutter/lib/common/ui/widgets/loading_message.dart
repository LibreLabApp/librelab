import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:material_ui/material_ui.dart';

class const LoadingMessage({
  super.key,
  required final String message,
  final String? description,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Center(
      child: Column(
        mainAxisSize: .min,
        children: [
          const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          const SizedBox(height: 20),
          Text(message, style: textTheme.titleMedium, textAlign: .center),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              style: textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: .center,
            ),
          ],
        ],
      ),
    );
  }
}
