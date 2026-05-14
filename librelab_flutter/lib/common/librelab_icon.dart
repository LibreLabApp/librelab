import 'package:flutter/material.dart';

class LibreLabIcon {
  static Widget framed({double borderWidth = 2, EdgeInsetsGeometry? padding}) =>
      _IconFrame(
        borderWidth: borderWidth,
        padding: padding ?? const EdgeInsets.all(32),
        child: const _GradientGrid(),
      );

  static Widget nonFramed() => const _GradientGrid();
}

class _IconFrame extends StatelessWidget {
  const _IconFrame({
    required this.child,
    required this.borderWidth,
    required this.padding,
  });
  final Widget child;
  final double borderWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white10, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 30,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Center(
              child: Padding(padding: padding, child: child),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientGrid extends StatelessWidget {
  const _GradientGrid();

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
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _colors[i],
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [_box(0), const SizedBox(width: 16), _box(1)]),
        const SizedBox(height: 16),
        Row(children: [_box(2), const SizedBox(width: 16), _box(3)]),
      ],
    );
  }
}
