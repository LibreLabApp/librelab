import 'package:material_ui/material_ui.dart';

abstract final class LibreLabIcon {
  static Widget framed({double borderWidth = 2, EdgeInsetsGeometry? padding}) =>
      _IconFrame(
        borderWidth: borderWidth,
        padding: padding ?? const .all(32),
        child: const _GradientGrid(),
      );

  static Widget nonFramed() => const _GradientGrid();
}

class const _IconFrame({
  required final Widget child,
  required final double borderWidth,
  required final EdgeInsetsGeometry padding,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const .all(40),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: .circular(100),
            border: .all(color: Colors.white10, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 30,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: .circular(100),
            child: Center(
              child: Padding(padding: padding, child: child),
            ),
          ),
        ),
      ),
    );
  }
}

class const _GradientGrid() extends StatelessWidget {
  static final _colors = [
    [const Color(0xFF0078D7), const Color(0xFF005A9E)],
    [const Color(0xFF107C10), const Color(0xFF0B5A0B)],
    [const Color(0xFF6849AD), const Color(0xFF4B3280)],
    [const Color(0xFFD81E05), const Color(0xFF991503)],
  ];

  Widget _box(int i) => Expanded(
    child: AspectRatio(
      aspectRatio: 6 / 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: .circular(12),
          gradient: LinearGradient(
            begin: .topLeft,
            end: .bottomRight,
            colors: _colors[i],
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Row(children: [_box(0), const SizedBox(width: 16), _box(1)]),
        const SizedBox(height: 16),
        Row(children: [_box(2), const SizedBox(width: 16), _box(3)]),
      ],
    );
  }
}
