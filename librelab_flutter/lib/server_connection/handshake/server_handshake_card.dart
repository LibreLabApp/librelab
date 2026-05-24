import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_client/librelab_client.dart';
import 'package:librelab_flutter/common/ui/widgets/alert_card.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/cubit/local_discovery_cubit.dart';
import 'package:librelab_flutter/server_connection/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';

/// A card that triggers a server handshake via an action button.
///
/// The handshake verifies that a selected server is reachable and
/// compatible with the current app version.
class ServerHandshakeCard extends StatelessWidget {
  const ServerHandshakeCard({super.key, required this.requestServerUrlFocus});

  final void Function() requestServerUrlFocus;

  @override
  Widget build(BuildContext context) {
    // TODO: (MDNS) Disable if no server is selected
    final t = context.t.serverHandshake;
    return AlertCard(
      type: .note,
      prefixIcon: Icons.wifi,
      suffix: Padding(
        padding: const EdgeInsetsGeometry.only(left: 16, top: 16),
        child: OutlinedButton(
          onPressed: () async {
            // TODO: (MDNS) Temporary prototype code!
            // START
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
              ServerSelectionMethod.localNetworkDiscovery =>
                'http://${context.read<LocalDiscoveryCubit>().state.selectedServerId}',
              ServerSelectionMethod.manual => selectionState.manualServerUrl,
            };
            final messenger = ScaffoldMessenger.of(context);
            if (selected == null) {
              messenger.showSnackBar(
                const SnackBar(content: Text('Please select a server first')),
              );
              return;
            }
            final client = Client(selected);
            try {
              final response = await client.handshake.check(
                clientApiContractVersion: ApiContractVersionConstants.version,
              );
              messenger.showSnackBar(
                SnackBar(
                  content: Text('Successful handshake: ${response.toJson()}'),
                ),
              );
            } on Exception catch (e) {
              messenger.showSnackBar(
                SnackBar(content: Text('Handshake failed: $e')),
              );
              Logger('TestConnection').warning('Handshake failed: $e');
            } finally {
              client.close();
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
