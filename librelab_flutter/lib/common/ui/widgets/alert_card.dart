import 'package:flutter/material.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';

enum AlertType { danger, error, warning, note, success }

class const AlertCard({
  super.key,
  required final AlertType _type,
  required final Widget _title,
  required final Widget _subtitle,
  required final IconData? _prefixIcon,
  required final Widget Function(Color color)? _suffix,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    final isDark = context.isDark;

    final (icon, color, containerColor) = switch (_type) {
      .danger => (
        Icons.warning_amber_rounded,
        colorScheme.error,
        colorScheme.errorContainer,
      ),
      .error => (
        Icons.error_outline_rounded,
        colorScheme.error,
        colorScheme.errorContainer,
      ),
      .note => (Icons.note, colorScheme.primary, colorScheme.primaryContainer),
      .warning => (
        Icons.warning_amber_rounded,
        isDark ? Colors.amber.shade300 : Colors.amber.shade800,
        isDark ? Colors.amber.shade900 : Colors.amber.shade50,
      ),
      .success => (
        Icons.check_circle_outline_rounded,
        isDark ? Colors.green.shade300 : Colors.green.shade700,
        isDark ? Colors.green.shade900 : Colors.green.shade50,
      ),
    };

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: containerColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_prefixIcon ?? icon, color: color, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                  child: _title,
                ),
                const SizedBox(height: 4.0),
                DefaultTextStyle(
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                  child: _subtitle,
                ),
              ],
            ),
          ),
          ?_suffix?.call(color),
        ],
      ),
    );
  }
}
