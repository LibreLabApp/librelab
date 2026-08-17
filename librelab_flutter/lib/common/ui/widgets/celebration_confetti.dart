import 'package:confetti/confetti.dart';
import 'package:flutter/widgets.dart';

class const CelebrationConfetti({
  super.key,
  required final Widget Function(
    BuildContext context,
    ConfettiController controller,
  )
  builder,
}) extends StatefulWidget {
  @override
  State<CelebrationConfetti> createState() => _CelebrationConfettiState();
}

class _CelebrationConfettiState extends State<CelebrationConfetti> {
  late final _controller = ConfettiController(
    duration: const Duration(seconds: 1),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.builder(context, _controller),
        Align(
          alignment: .topCenter,
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirectionality: .explosive,
            shouldLoop: false,
          ),
        ),
      ],
    );
  }
}
