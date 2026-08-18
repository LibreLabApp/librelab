import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/login_identity/cubit/login_identity_cubit.dart';
import 'package:material_ui/material_ui.dart';

/// An icon button that displays the available servers and their login
/// identities, allowing the user to switch the selected login identity.
class const LoginIdentitySwitcherIconButton({
  super.key,
  required final String tooltip,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Switching between login identities is not smooth in the UI. Investigate.
    //  Cause seems to be setting: refreshListenable: refreshListenable: GoRouterRefreshStream([loginIdentityCubit.stream]) in main.dart
    final successState = context.select((LoginIdentityCubit v) {
      final state = v.state;

      if (state is Loading) {
        return null;
      }

      if (state is! Success) {
        throw StateError(
          'LoginIdentitySwitcherIconButton requires LoginIdentityCubit to be in the Success state.\n'
          'Actual: ${state.runtimeType}',
        );
      }

      return state;
    });

    if (successState == null) {
      return const SizedBox.shrink();
    }

    final selectedLoginIdentity =
        successState.selectedLoginIdentity ??
        (throw StateError(
          'LoginIdentitySwitcherIconButton requires a selected login identity.',
        ));

    final loginIdentities = successState.loginIdentities;

    return MenuAnchor(
      menuChildren: loginIdentities.servers.map((server) {
        final filteredLoginIdentities = loginIdentities.loginIdentities
            .where((loginIdentity) => loginIdentity.serverId == server.id)
            .toList();

        return SubmenuButton(
          leadingIcon: const Icon(Icons.dns_outlined),
          menuChildren: filteredLoginIdentities.map((loginIdentity) {
            return MenuItemButton(
              leadingIcon: _Icon(fullName: loginIdentity.user.fullName),
              child: Text(loginIdentity.user.fullName),
              onPressed: () => context
                  .read<LoginIdentityCubit>()
                  .selectLoginIdentity(loginIdentity.id),
            );
          }).toList(),
          child: Text(server.name),
        );
      }).toList(),
      builder: (context, controller, child) => IconButton(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        icon: _Icon(
          fullName: selectedLoginIdentity.loginIdentity.user.fullName,
        ),
        tooltip: tooltip,
      ),
    );
  }
}

class const _Icon({required final String fullName}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CircleAvatar(
      radius: 16,
      backgroundColor: theme.colorScheme.inversePrimary,
      child: Text(fullName[0].toUpperCase()),
    );
  }
}
