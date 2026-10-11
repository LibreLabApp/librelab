import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/login_identity/cubit/login_identity_cubit.dart';
import 'package:librelab_flutter/login_identity/models/login_identities.dart';
import 'package:librelab_flutter/login_identity/models/login_identity.dart';
import 'package:librelab_flutter/login_identity/ui/add_login_identity/add_login_identity_page.dart';
import 'package:material_ui/material_ui.dart';

/// A menu anchor that displays the available servers and their login
/// identities, allowing the user to change the selected login identity, with
/// an option to add another login identity.
class const LoginIdentitySelectorMenuAnchor({super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = context.t.loginIdentitySelectorMenuAnchor;

    final successState = context.select((LoginIdentityCubit v) {
      final state = v.state.loadState;

      if (state is LoadLoginIdentitiesLoading) {
        return null;
      }

      if (state is! LoadLoginIdentitiesSuccess) {
        throw StateError(
          'LoginIdentitySelectorMenuAnchor widget requires LoginIdentityCubit to be in the Success state.\n'
          'Actual: ${state.runtimeType}',
        );
      }

      return state;
    });

    if (successState == null) {
      return const SizedBox.shrink();
    }

    final selectedLoginIdentity =
        successState.selectedLoginIdentity?.loginIdentity;

    if (selectedLoginIdentity == null) {
      return const SizedBox.shrink();
    }

    final loginIdentities = successState.loginIdentities;

    return MenuAnchor(
      menuChildren: [
        MenuItemButton(
          leadingIcon: const Icon(Icons.add),
          child: Text(t.addButton),
          onPressed: () => context.push(AddLoginIdentityPage.routePath),
        ),
        const Divider(),
        ..._buildLoginIdentitySelectionItems(
          loginIdentities,
          selectedLoginIdentity,
          context.read<LoginIdentityCubit>(),
        ),
      ],
      builder: (context, controller, child) => IconButton(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        icon: _LoginIdentityIcon(fullName: selectedLoginIdentity.user.fullName),
        tooltip: t.tooltip,
      ),
    );
  }

  /// Builds menu items for selecting a login identity, grouped by server.
  List<Widget> _buildLoginIdentitySelectionItems(
    LoginIdentities loginIdentities,
    LoginIdentity selectedLoginIdentity,
    LoginIdentityCubit cubit,
  ) => loginIdentities.servers.map((server) {
    final filteredLoginIdentities = loginIdentities.list
        .where((loginIdentity) => loginIdentity.serverId == server.id)
        .toList();

    return SubmenuButton(
      leadingIcon: const Icon(Icons.dns_outlined),
      menuChildren: filteredLoginIdentities.map((loginIdentity) {
        final isSelected = loginIdentity.id == selectedLoginIdentity.id;

        return MenuItemButton(
          leadingIcon: _LoginIdentityIcon(
            fullName: loginIdentity.user.fullName,
          ),
          trailingIcon: isSelected
              ? const Padding(
                  padding: EdgeInsetsDirectional.only(start: 8),
                  child: Icon(Icons.check),
                )
              : null,
          onPressed: () => cubit.selectLoginIdentity(loginIdentity.id),
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsetsDirectional.symmetric(horizontal: 12),
            ),
          ),
          child: Text(loginIdentity.user.fullName),
        );
      }).toList(),
      child: Text(server.name),
    );
  }).toList();
}

class const _LoginIdentityIcon({required final String fullName})
    extends StatelessWidget {
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
