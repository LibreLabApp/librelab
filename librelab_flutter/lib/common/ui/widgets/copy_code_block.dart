import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/copy_text_icon_button.dart';
import 'package:material_ui/material_ui.dart';

class const CopyCodeBlock({super.key, required final String code})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: const .all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: .circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 16,
                fontWeight: .bold,
              ),
            ),
          ),
          CopyTextIconButton(tooltip: context.ml.copyButtonLabel, text: code),
        ],
      ),
    );
  }
}
