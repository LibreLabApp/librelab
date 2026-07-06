import 'package:flutter/widgets.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';

class const DecorativeIcon(final IconData _icon, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        _icon,
        size: 52,
        color: context.theme.colorScheme.onPrimaryContainer,
      ),
    );
  }
}
