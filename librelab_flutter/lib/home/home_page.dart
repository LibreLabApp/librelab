import 'package:librelab_flutter/common/ui/widgets/celebration_confetti.dart';
import 'package:material_ui/material_ui.dart';

class const HomePage({super.key}) extends StatelessWidget {
  static const String routePath = '/';

  @override
  Widget build(BuildContext context) {
    // TODO: Temporary page for super very build testing
    return Directionality(
      textDirection: .ltr,
      child: CelebrationConfetti(
        builder: (context, controller) {
          controller.play();
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisSize: .min,
                children: [
                  const Icon(Icons.check_circle_outline, size: 72),
                  const SizedBox(height: 24),
                  Text(
                    'Thank you!',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Thank you for trying this very early build.\nYour feedback helps shape what comes next.',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: .center,
                  ),
                  const SizedBox(height: 24),
                  // TODO: Implement
                  FilledButton(onPressed: () {}, child: const Text('Logout')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
