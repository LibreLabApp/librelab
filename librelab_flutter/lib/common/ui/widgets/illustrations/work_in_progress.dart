import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Illustrates that the displayed area is still under development.
//
// Disclaimer: This widget is mostly AI-generated with minor changes.
class WorkInProgressIllustration extends StatefulWidget {
  const new({super.key, this.width = 240, this.height = 180});

  final double width;
  final double height;

  @override
  State<WorkInProgressIllustration> createState() =>
      _WorkInProgressIllustrationState();
}

class _WorkInProgressIllustrationState extends State<WorkInProgressIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _progress = Tween<double>(
      begin: 0.25,
      end: 0.75,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => CustomPaint(
          painter: _WorkInProgressPainter(
            progress: _progress.value,
            phase: _controller.value * 2 * math.pi,
            primary: colorScheme.primary,
            secondary: colorScheme.secondary,
            surface: colorScheme.surfaceContainerHighest,
            outline: colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }
}

class _WorkInProgressPainter extends CustomPainter {
  const new({
    required this.progress,
    required this.phase,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.outline,
  });

  final double progress;
  final double phase;
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color outline;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 240, size.height / 180);

    final fill = Paint()..style = PaintingStyle.fill;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Soft background accent.
    fill.color = primary.withValues(alpha: 0.07);
    canvas.drawCircle(const Offset(120, 87), 68, fill);

    // Floating decorative dots.
    for (var i = 0; i < 4; i++) {
      final angle = phase + i * math.pi / 2;
      final center = Offset(
        120 + math.cos(angle) * 83,
        83 + math.sin(angle) * 58,
      );

      fill.color = (i.isEven ? primary : secondary).withValues(
        alpha: 0.45 + 0.35 * (math.sin(angle) + 1) / 2,
      );
      canvas.drawCircle(center, i.isEven ? 3.5 : 2.5, fill);
    }

    // Main work card.
    final card = RRect.fromRectAndRadius(
      const Rect.fromLTWH(51, 22, 138, 125),
      const Radius.circular(13),
    );

    fill.color = surface;
    canvas.drawRRect(card, fill);

    stroke.color = outline;
    canvas.drawRRect(card, stroke);

    // Card header.
    fill.color = primary.withValues(alpha: 0.14);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(65, 35, 110, 23),
        const Radius.circular(6),
      ),
      fill,
    );

    fill.color = primary;
    canvas.drawCircle(const Offset(76, 46.5), 3, fill);

    stroke
      ..color = primary
      ..strokeWidth = 2;
    canvas.drawLine(const Offset(86, 46.5), const Offset(125, 46.5), stroke);

    // Content lines.
    stroke
      ..color = outline
      ..strokeWidth = 3.5;
    canvas.drawLine(const Offset(68, 72), const Offset(142, 72), stroke);
    canvas.drawLine(const Offset(68, 85), const Offset(126, 85), stroke);

    // Animated progress bar.
    fill.color = outline.withValues(alpha: 0.35);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(68, 101, 104, 8),
        const Radius.circular(4),
      ),
      fill,
    );

    fill.color = primary;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(68, 101, 104 * progress, 8),
        const Radius.circular(4),
      ),
      fill,
    );

    // Small construction pencil.
    canvas.save();
    canvas.translate(166, 117);
    canvas.rotate(-math.pi / 4);

    fill.color = secondary;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-7, -24, 14, 47),
        const Radius.circular(4),
      ),
      fill,
    );

    fill.color = primary;
    canvas.drawRect(const Rect.fromLTWH(-7, -24, 14, 8), fill);

    fill.color = outline;
    canvas.drawPath(
      Path()
        ..moveTo(-7, 23)
        ..lineTo(7, 23)
        ..lineTo(0, 32)
        ..close(),
      fill,
    );

    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WorkInProgressPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.phase != phase ||
      oldDelegate.primary != primary ||
      oldDelegate.secondary != secondary ||
      oldDelegate.surface != surface ||
      oldDelegate.outline != outline;
}
