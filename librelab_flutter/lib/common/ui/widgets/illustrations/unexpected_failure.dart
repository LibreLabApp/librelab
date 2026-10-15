import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

const _designSize = Size(220, 180);

/// An animated illustration indicating an unexpected failure.
//
// Disclaimer: This widget is mostly AI-generated with minor changes.
class const UnexpectedFailureIllustration({super.key}) extends StatefulWidget {
  @override
  State<UnexpectedFailureIllustration> createState() =>
      _UnexpectedFailureIllustrationState();
}

class _UnexpectedFailureIllustrationState
    extends State<UnexpectedFailureIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RepaintBoundary(
      child: SizedBox.fromSize(
        size: _designSize,
        child: CustomPaint(
          painter: _UnexpectedFailurePainter(
            _controller,
            colorScheme: colorScheme,
          ),
        ),
      ),
    );
  }
}

class _UnexpectedFailurePainter extends CustomPainter {
  new(Animation<double> animation, {required this.colorScheme})
    : _animation = animation,
      super(repaint: animation);

  final Animation<double> _animation;
  final ColorScheme? colorScheme;

  Color get _paperColor =>
      colorScheme?.surfaceContainerLow ?? const Color(0xFFF4F4F5);
  Color get _mutedColor =>
      colorScheme?.outlineVariant ?? const Color(0xFFD4D4D8);
  Color get _errorColor => colorScheme?.error ?? const Color(0xFFDC4545);
  Color get _onErrorColor => colorScheme?.onError ?? Colors.white;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(
      size.width / _designSize.width,
      size.height / _designSize.height,
    );

    final t = _animation.value;
    final float = math.sin(t * math.pi) * 5;
    final rotation = math.sin(t * math.pi) * 0.035;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(scale);
    canvas.translate(0, -float);
    canvas.rotate(rotation);

    _drawDocument(canvas);
    _drawFragments(canvas, t);
    _drawWarning(canvas, t);

    canvas.restore();
  }

  void _drawDocument(Canvas canvas) {
    final paper = RRect.fromRectAndRadius(
      const Rect.fromLTRB(-48, -57, 32, 47),
      const Radius.circular(9),
    );

    canvas.drawShadow(
      Path()..addRRect(paper),
      (colorScheme?.shadow ?? Colors.black).withValues(alpha: 0.12),
      8,
      true,
    );

    canvas.drawRRect(paper, Paint()..color = _paperColor);

    canvas.drawRRect(
      paper,
      Paint()
        ..color = _mutedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Folded document corner.
    final fold = Path()
      ..moveTo(12, -57)
      ..lineTo(12, -37)
      ..quadraticBezierTo(12, -32, 17, -32)
      ..lineTo(32, -32)
      ..close();

    canvas.drawPath(
      fold,
      Paint()
        ..color =
            colorScheme?.surfaceContainerHighest ?? const Color(0xFFE4E4E7),
    );

    canvas.drawPath(
      Path()
        ..moveTo(12, -57)
        ..lineTo(12, -37)
        ..quadraticBezierTo(12, -32, 17, -32)
        ..lineTo(32, -32),
      Paint()
        ..color = _mutedColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );

    // Incomplete content lines.
    final linePaint = Paint()
      ..color = _mutedColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(-31, -20), const Offset(8, -20), linePaint);
    canvas.drawLine(const Offset(-31, -7), const Offset(16, -7), linePaint);
    canvas.drawLine(const Offset(-31, 6), const Offset(-9, 6), linePaint);

    // Jagged crack through the document.
    final crack = Path()
      ..moveTo(-2, 9)
      ..lineTo(-12, 19)
      ..lineTo(-3, 23)
      ..lineTo(-17, 37)
      ..lineTo(-9, 28)
      ..lineTo(-17, 25)
      ..lineTo(-9, 15);

    canvas.drawPath(
      crack,
      Paint()
        ..color = _errorColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  void _drawWarning(Canvas canvas, double t) {
    final pulse = 1 + math.sin(t * math.pi * 2) * 0.045;

    canvas.save();
    canvas.translate(39, 31);
    canvas.scale(pulse);

    // Soft warning halo.
    canvas.drawCircle(
      Offset.zero,
      27,
      Paint()..color = _errorColor.withValues(alpha: 0.10),
    );

    canvas.drawCircle(Offset.zero, 21, Paint()..color = _errorColor);

    final whitePaint = Paint()
      ..color = _onErrorColor
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(0, -9), const Offset(0, 3), whitePaint);

    canvas.drawCircle(const Offset(0, 10), 2, Paint()..color = _onErrorColor);

    canvas.restore();
  }

  void _drawFragments(Canvas canvas, double t) {
    final fragmentPaint = Paint()..color = _errorColor;

    final fragments = [
      (Offset(-67, -29 - t * 5), 0.0, 5.0),
      (Offset(57, -42 + t * 6), 0.8, 4.0),
      (Offset(65, 17 - t * 4), 1.4, 3.5),
      (Offset(-61, 45 + t * 3), 0.5, 3.0),
    ];

    for (final (position, angle, radius) in fragments) {
      canvas.save();
      canvas.translate(position.dx, position.dy);
      canvas.rotate(angle + t * 0.7);

      final path = Path()
        ..moveTo(0, -radius)
        ..lineTo(radius * 0.7, 0)
        ..lineTo(0, radius)
        ..lineTo(-radius * 0.7, 0)
        ..close();

      canvas.drawPath(path, fragmentPaint);
      canvas.restore();
    }

    // Small neutral decorative dots.
    final dotPaint = Paint()..color = _mutedColor;

    canvas.drawCircle(Offset(-70, 2 + math.sin(t * math.pi) * 3), 2, dotPaint);
    canvas.drawCircle(
      Offset(68, -9 - math.sin(t * math.pi) * 3),
      2.5,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _UnexpectedFailurePainter oldDelegate) {
    return oldDelegate._animation != _animation ||
        oldDelegate.colorScheme != colorScheme;
  }
}
