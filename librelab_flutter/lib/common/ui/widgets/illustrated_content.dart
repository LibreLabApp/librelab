import 'package:flutter/widgets.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';

/// Displays a title, subtitle, and additional content alongside an
/// illustration, using a vertical or horizontal layout depending on
/// available width.
class const IllustratedContent({
  super.key,
  required final Widget title,
  required final Widget subtitle,
  required final Widget illustration,
  required final Widget content,
  final double titleSubtitleSpacing = 16,
  final double subtitleContentSpacing = 32,
}) extends StatelessWidget {
  static const _verticalLayoutBreakpoint = 780.0;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final (textTheme, colorScheme) = (theme.textTheme, theme.colorScheme);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isVertical = constraints.maxWidth < _verticalLayoutBreakpoint;

        final textContent = Padding(
          padding: EdgeInsets.all(isVertical ? 24 : 32),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .start,
            children: [
              DefaultTextStyle.merge(
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                child: title,
              ),
              SizedBox(height: titleSubtitleSpacing),
              DefaultTextStyle.merge(
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
                child: subtitle,
              ),
              SizedBox(height: subtitleContentSpacing),
              content,
            ],
          ),
        );

        final illustrationWidth =
            constraints.maxWidth * (isVertical ? 0.7 : 0.4);
        final illustrationContent = Center(
          child: SizedBox(
            width: illustrationWidth,
            height: illustrationWidth * 0.8,
            child: illustration,
          ),
        );

        return Flex(
          direction: isVertical ? .vertical : .horizontal,
          children: [
            if (isVertical) ...[
              textContent,
              illustrationContent,
            ] else ...[
              Expanded(child: textContent),
              Expanded(child: illustrationContent),
            ],
          ],
        );
      },
    );
  }
}
