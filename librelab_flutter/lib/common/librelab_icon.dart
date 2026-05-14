import 'package:flutter/material.dart';

class LibreLabIcon extends StatelessWidget {
  const LibreLabIcon({super.key, this.isFramedIcon = false});
  final bool isFramedIcon;

  @override
  Widget build(BuildContext context) {
    const child = _GradientGrid();
    if (isFramedIcon) {
      return const _IconFrame(child: child);
    }
    return const Padding(padding: EdgeInsets.all(24), child: child);
  }
}

class _IconFrame extends StatelessWidget {
  const _IconFrame({required this.child});
  final Widget child;

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
            border: Border.all(color: Colors.white10, width: 2),
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
              child: Padding(padding: const EdgeInsets.all(32), child: child),
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

  Widget box(int i) => Expanded(
    child: AspectRatio(
      aspectRatio: 1.2,
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
        Row(children: [box(0), const SizedBox(width: 16), box(1)]),
        const SizedBox(height: 16),
        Row(children: [box(2), const SizedBox(width: 16), box(3)]),
      ],
    );
  }
}
