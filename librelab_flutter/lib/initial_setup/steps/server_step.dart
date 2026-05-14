import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/alert_card.dart';
import 'package:librelab_flutter/common/build_context_ext.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';
import 'package:librelab_flutter/local_network_discovery/cubit/local_discovery_cubit.dart';
import 'package:librelab_flutter/local_network_discovery/discovered_server.dart';

class InitialSetupServerStep extends StatelessWidget {
  const InitialSetupServerStep({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Hack: Adds top padding so the floating label of the first outlined TextField/ServerSelection isn't clipped inside PageView
        SizedBox(height: 4),
        _ServerSelection(),
        SizedBox(height: 18),
        Spacer(),
        _TestConnection(),
      ],
    );
  }
}

// TODO: (MDNS) Extract/move this into a cubit, must be reusable outside of initial screen page
enum _ServerConnectionMode { localNetworkDiscovery, manual }

class _ServerSelection extends StatefulWidget {
  const _ServerSelection();

  @override
  State<_ServerSelection> createState() => _ServerSelectionState();
}

class _ServerSelectionState extends State<_ServerSelection> {
  // TODO: (MDNS) Manage inside cubit?
  _ServerConnectionMode _mode = .localNetworkDiscovery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: .infinity,
          child: SegmentedButton<_ServerConnectionMode>(
            showSelectedIcon: false,
            style: SegmentedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
              tapTargetSize: .padded,
            ),
            onSelectionChanged: (value) {
              setState(() => _mode = value.first);
              if (_mode == .manual) {
                // TODO: If selected server index is not null, thne autofill the text when switching to TextField
              }
              // TODO: When switching to .localNetwork, make sure to choose the right address
            },
            segments: _ServerConnectionMode.values
                .map<ButtonSegment<_ServerConnectionMode>>((e) {
                  final t = context.t.server;
                  final label = switch (e) {
                    .localNetworkDiscovery =>
                      t.connectionMethod.localNetworkDiscovery.button,
                    .manual => t.connectionMethod.manualAddress.button,
                  };
                  final icon = switch (e) {
                    .localNetworkDiscovery => Icons.wifi,
                    .manual => Icons.public,
                  };
                  final tooltip = switch (e) {
                    .localNetworkDiscovery =>
                      t.connectionMethod.localNetworkDiscovery.tooltip,
                    .manual => t.connectionMethod.manualAddress.tooltip,
                  };

                  return ButtonSegment(
                    value: e,
                    label: Text(label),
                    icon: Icon(icon),
                    tooltip: tooltip,
                  );
                })
                .toList(),
            selected: {_mode},
          ),
        ),
        const SizedBox(height: 16),
        switch (_mode) {
          _ServerConnectionMode.localNetworkDiscovery =>
            const _ServerAddressLocalNetwork(),
          _ServerConnectionMode.manual => const _ServerAddressTextField(),
        },
      ],
    );
  }
}

class _ServerAddressTextField extends StatefulWidget {
  const _ServerAddressTextField();

  @override
  State<_ServerAddressTextField> createState() =>
      _ServerAddressTextFieldState();
}

class _ServerAddressTextFieldState extends State<_ServerAddressTextField> {
  final TextEditingController _serverUrlController = TextEditingController();

  @override
  void dispose() {
    _serverUrlController.removeListener(_onServerUrlChanged);
    _serverUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _serverUrlController.text =
        context.read<InitialSetupCubit>().state.serverUrl ?? '';
    _serverUrlController.addListener(_onServerUrlChanged);
    super.initState();
  }

  /// Syncs the value of [_serverUrlController.text] with [InitialSetupState.serverUrl].
  ///
  /// Note: This subscribes to [_serverUrlController] changes instead of relying on
  /// [TextField.onChanged], so updates are captured for both user input and
  /// programmatic assignments (e.g., `controller.text = ...`).
  void _onServerUrlChanged() {
    context.read<InitialSetupCubit>().setServerUrl(_serverUrlController.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _serverUrlController,
      maxLines: 1,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: const [AutofillHints.url],
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      decoration: InputDecoration(
        // errorText: , // TODO: VALIDATE
        prefixIcon: const Icon(Icons.dns),
        border: const OutlineInputBorder(),
        hintText: 'e.g., https://example.com',
        labelText: 'Server URL',
        helperText: 'Enter the base URL of your server',
        suffixIcon: ValueListenableBuilder(
          valueListenable: _serverUrlController,
          builder: (context, value, _) {
            if (value.text.isEmpty) {
              return const Tooltip(
                constraints: BoxConstraints(maxWidth: 300),
                message:
                    'Base address of the server. Can be provided by a service administrator or self-hosted.',
                child: Icon(Icons.info_outline),
              );
            }
            return IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _serverUrlController.clear,
            );
          },
        ),
      ),
    );
  }
}

class _ServerAddressLocalNetwork extends StatefulWidget {
  const _ServerAddressLocalNetwork();

  @override
  State<_ServerAddressLocalNetwork> createState() =>
      _ServerAddressLocalNetworkState();
}

class _ServerAddressLocalNetworkState
    extends State<_ServerAddressLocalNetwork> {
  @override
  void initState() {
    context.read<LocalDiscoveryCubit>().scan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.t.server.localNetworkDiscovery.serverListTitle,
                style: textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              BlocSelector<LocalDiscoveryCubit, LocalDiscoveryState, bool>(
                selector: (state) => state.isLoading,
                builder: (context, isLoading) {
                  return TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: textTheme.titleMedium,
                    ),
                    onPressed: isLoading
                        ? null
                        : () => context.read<LocalDiscoveryCubit>().scan(
                            refresh: true,
                          ),
                    label: Text(
                      context
                          .t
                          .server
                          .localNetworkDiscovery
                          .refreshServersButton,
                    ),
                    icon: const Icon(Icons.refresh),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: Builder(
              builder: (context) {
                final discoveredServers = context.select(
                  (LocalDiscoveryCubit v) => v.state.discoveredServers,
                );
                final isLoading = context.select(
                  (LocalDiscoveryCubit v) => v.state.isLoading,
                );

                // TODO: (MDNS) Handle empty
                final noServersFound = discoveredServers.isEmpty && !isLoading;

                return Column(
                  children: [
                    // TODO: (MDNS) Better loading
                    if (isLoading) const LinearProgressIndicator(),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: discoveredServers.length,
                        itemBuilder: (context, index) => _ServerTile(
                          server: discoveredServers[index],
                          index: index,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.t.server.localNetworkDiscovery.discoveredServerPrompt,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServerTile extends StatelessWidget {
  const _ServerTile({required this.server, required this.index});

  final DiscoveredServer server;
  final int index;

  @override
  Widget build(BuildContext context) {
    final selectedServerId = context.select(
      (LocalDiscoveryCubit c) => c.state.selectedServerId,
    );

    return RadioGroup<String>(
      onChanged: (newId) =>
          context.read<LocalDiscoveryCubit>().selectServer(newId),
      groupValue: selectedServerId,
      child: ListTile(
        onTap: () =>
            context.read<LocalDiscoveryCubit>().selectServer(server.id),
        // TODO: (MDNS) Show snackbar
        onLongPress: () =>
            Clipboard.setData(ClipboardData(text: server.uri.toString())),
        title: Text(server.instanceName),
        subtitle: Text(server.authority),
        leading: Row(
          mainAxisSize: .min,
          spacing: 8,
          children: [
            Radio<String>(value: server.id),
            Tooltip(
              message: server.serverVersion != null
                  ? 'v${server.serverVersion}'
                  : '', // Must be empty if null,
              child: const Icon(Icons.dns),
            ),
          ],
        ),
        trailing: server.pingMs == null
            ? null
            : Row(
                mainAxisSize: .min,
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: server.hasLowPing ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 6),
                  Text('${server.pingMs!} ms'),
                ],
              ),
      ),
    );
  }
}

class _TestConnection extends StatelessWidget {
  const _TestConnection();

  @override
  Widget build(BuildContext context) {
    // TODO: (MDNS) Disable if no server is selected
    final t = context.t.server.testConnection;
    return AlertCard(
      type: .note,
      prefixIcon: Icons.wifi,
      suffix: Padding(
        padding: const EdgeInsetsGeometry.only(left: 16, top: 16),
        child: OutlinedButton(onPressed: () {}, child: Text(t.button)),
      ),
      title: Text(t.title),
      subtitle: Text(t.subtitle),
    );
  }
}
