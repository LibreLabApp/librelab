import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/adaptive_scaffold.dart';
import 'package:librelab_flutter/common/ui/widgets/celebration_confetti.dart';
import 'package:librelab_flutter/login_identity/ui/login_identity_switcher_icon_button.dart';
import 'package:librelab_shared/librelab_shared.dart' show ProjectConstants;
import 'package:material_ui/material_ui.dart';

class const HomePage({super.key}) extends StatelessWidget {
  static const String routePath = '/';

  @override
  Widget build(BuildContext context) {
    final t = context.t.homePage;

    return AdaptiveScaffold(
      appBar: (actions, {required bool isNavigationRail}) => isNavigationRail
          ? null
          : AppBar(
              actions: actions,
              title: const Text(ProjectConstants.displayName),
            ),
      // TODO: Prefer an enum
      navigationItems: [
        NavigationItem(
          unselectedIcon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: t.destinations.settings.label,
          // TODO: Implement settings
          body: const Text('Settings content'),
        ),
        const NavigationItem(
          unselectedIcon: Icon(Icons.celebration),
          selectedIcon: Icon(Icons.celebration_outlined),
          label: 'Thanks',
          body: _ThankYouForTryingEarlyBuild(),
        ),
      ],
      actions: ({required bool isNavigationRail}) => [
        IconButton(
          onPressed: () {
            // TODO: Implement. Warn from logging out when login is disabled (lab settings).
          },
          icon: const Icon(Icons.logout),
          tooltip: t.actions.logout,
        ),
        if (isNavigationRail) const SizedBox(height: 10),
        if (!isNavigationRail) const SizedBox(width: 5),
        LoginIdentitySwitcherIconButton(tooltip: t.actions.switchUser),
        if (isNavigationRail) const SizedBox(height: 20),
        if (!isNavigationRail) const SizedBox(width: 10),
      ],
      // TODO: Add an option in settings to override the default?
      defaultIndex: 1,
    );
  }
}

// TODO: Temporary page for super very build testing
class const _ThankYouForTryingEarlyBuild() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
