import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/alert_card.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_compatibility_repository.dart';
import 'package:librelab_flutter/server_selection/local_network_discovery/cubit/local_discovery_cubit.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';

/// A card that triggers an API server compatibility check via an action button.
///
/// Verifies that a selected server is reachable and
/// compatible with the current app version.
class const ServerCompatibilityCheckCard({
  super.key,
  required final void Function() requestServerUrlFocus,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: (MDNS) Disable if no server is selected
    final t = context.t.serverCompatibility.check;
    return AlertCard(
      type: .note,
      prefixIcon: Icons.wifi,
      suffix: Padding(
        padding: const EdgeInsetsGeometry.only(left: 16, top: 16),
        child: OutlinedButton(
          onPressed: () async {
            // TODO: (MDNS) Temporary prototype code!
            // START
            final logger = Logger('TestConnection');

            final selectionState = context.read<ServerSelectionCubit>().state;
            if (selectionState.selectionMethod == .manual) {
              final input = selectionState.manualServerUrl ?? '';
              final isInvalid = validateHttpUrl(input) != null;
              if (isInvalid) {
                requestServerUrlFocus();
                return;
              }
            }

            final selected = switch (selectionState.selectionMethod) {
              .localNetworkDiscovery => () {
                final selected = context
                    .read<LocalDiscoveryCubit>()
                    .state
                    .selectedServerId;
                return selected != null ? 'http://$selected' : null;
              }(),
              .manual => selectionState.manualServerUrl,
            };
            final messenger = ScaffoldMessenger.of(context);
            if (selected == null) {
              messenger.showSnackBar(
                const SnackBar(content: Text('Please select a server first')),
              );
              return;
            }

            final repository = ServerCompatibilityRepository(
              client: context.read()..setBaseUrl(Uri.parse(selected)),
            );

            try {
              final response = await repository.check();

              messenger.showSnackBar(
                SnackBar(content: Text('Successful check: ${response.status}')),
              );
              // TODO: (HTTP_CLIENT) May handle this
            } /*on TlsException catch (e) {
              messenger.showSnackBar(SnackBar(content: Text('TLS: $e')));
              logger.warning('$TlsException: $e');
            } */ on Exception catch (e) {
              messenger.showSnackBar(
                SnackBar(content: Text('Check failed: $e')),
              );
              logger.warning('Check failed: $e');
              // ignore: avoid_catching_errors
            } on TypeError catch (e) {
              logger.warning('Response deserialization failed: $e');
            }
            // END
          },
          child: Text(t.button),
        ),
      ),
      title: Text(t.title),
      subtitle: Text(t.subtitle),
    );
  }
}
