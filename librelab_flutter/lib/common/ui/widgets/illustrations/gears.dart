import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

/// Displays continuously rotating gears using Flutter's canvas.
//
// Disclaimer: This widget is mostly AI-generated with minor changes.
// Originally this Lottie asset was being used:
// https://lottiefiles.com/free-animation/gears-lottie-animation-aaQcatXjOU
class GearsIllustration extends StatefulWidget {
  const new({
    super.key,
    this.size = 160,
    this.duration = const Duration(seconds: 4),
  });

  final double size;
  final Duration duration;

  @override
  State<GearsIllustration> createState() => _GearsIllustrationState();
}

class _GearsIllustrationState extends State<GearsIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant GearsIllustration oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller
        ..reset()
        ..repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox.square(
      dimension: widget.size,
      child: CustomPaint(
        painter: _GearsPainter(
          animation: _controller,
          color: colorScheme.primary,
          backgroundColor: colorScheme.surface,
        ),
      ),
    );
  }
}

class _GearsPainter extends CustomPainter {
  new({
    required this.animation,
    required this.color,
    required this.backgroundColor,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color color;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.shortestSide / 160;
    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2)
      ..scale(scale);

    final angle = animation.value * 2 * math.pi;

    // Draw the smaller gears first so the large gear appears in front.
    _drawGear(
      canvas,
      center: const Offset(34, -30),
      radius: 23,
      teeth: 10,
      angle: -angle * 1.5,
    );

    _drawGear(
      canvas,
      center: const Offset(43, 35),
      radius: 17,
      teeth: 8,
      angle: angle * 2,
    );

    _drawGear(
      canvas,
      center: const Offset(-20, 0),
      radius: 39,
      teeth: 12,
      angle: angle,
    );

    canvas.restore();
  }

  void _drawGear(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required int teeth,
    required double angle,
  }) {
    final rootRadius = radius * 0.79;
    final toothWidth = math.pi / teeth * 0.48;
    final path = Path();

    for (var i = 0; i < teeth * 4; i++) {
      final step = i % 4;
      final toothAngle = angle + (i ~/ 4) * 2 * math.pi / teeth;

      final r = switch (step) {
        0 || 3 => rootRadius,
        _ => radius,
      };

      final a =
          toothAngle +
          switch (step) {
            0 => -toothWidth,
            1 => -toothWidth,
            2 => toothWidth,
            _ => toothWidth,
          };

      final point = Offset(
        center.dx + r * math.cos(a),
        center.dy + r * math.sin(a),
      );

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.drawPath(path, paint);

    // Inner hub.
    canvas.drawCircle(
      center,
      radius * 0.52,
      paint..color = color.withValues(alpha: 0.78),
    );

    // Center opening.
    canvas.drawCircle(center, radius * 0.19, paint..color = backgroundColor);
  }

  @override
  bool shouldRepaint(_GearsPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.animation != animation;
  }
}
