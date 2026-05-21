import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_client/librelab_client.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/alert_card.dart';
import 'package:librelab_flutter/generated/assets.gen.dart';
import 'package:librelab_flutter/generated/pubspec.g.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';
import 'package:librelab_flutter/server_connection/local_network_discovery/cubit/local_discovery_cubit.dart';
import 'package:librelab_flutter/server_connection/local_network_discovery/discovered_server.dart';
import 'package:librelab_flutter/server_connection/server_selection/server_selection_method.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

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
        _TestConnection(),
      ],
    );
  }
}

class _ServerSelection extends StatefulWidget {
  const _ServerSelection();

  @override
  State<_ServerSelection> createState() => _ServerSelectionState();
}

class _ServerSelectionState extends State<_ServerSelection> {
  // TODO: (MDNS) Manage inside cubit?
  ServerSelectionMethod _mode = .localNetworkDiscovery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: .infinity,
          child: SegmentedButton<ServerSelectionMethod>(
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
            segments: ServerSelectionMethod.values
                .map<ButtonSegment<ServerSelectionMethod>>((e) {
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
          .localNetworkDiscovery => const _ServerAddressLocalNetwork(),
          .manual => const _ServerAddressTextField(),
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
      child: Builder(
        builder: (context) {
          final discoveredServers = context.select(
            (LocalDiscoveryCubit v) => v.state.discoveredServers,
          );
          final isLoading = context.select(
            (LocalDiscoveryCubit v) => v.state.isLoading,
          );

          final hasNoServers = discoveredServers.isEmpty;

          return Column(
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
                  TextButton.icon(
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
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Builder(
                builder: (context) {
                  return switch (hasNoServers) {
                    true => _NoServersFound(isLoading: isLoading),
                    false => ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 150),
                      child: _DiscoveredServersList(
                        isLoading: isLoading,
                        discoveredServers: discoveredServers,
                      ),
                    ),
                  };
                },
              ),

              const SizedBox(height: 8),
              if (!hasNoServers) ...[
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context
                            .t
                            .server
                            .localNetworkDiscovery
                            .discoveredServerPrompt,
                        style: textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final show = constraints.maxWidth > 94;
                            if (!show) {
                              return const SizedBox.shrink();
                            }
                            return Text(
                              context.t.server.localNetworkDiscovery
                                  .discoveredServersCount(
                                    n: discoveredServers.length,
                                  ),
                              style: textTheme.labelSmall,
                              textAlign: .end,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _NoServersFound extends StatelessWidget {
  const _NoServersFound({required this.isLoading});

  final bool isLoading;

  TextSpan _bulletSpan(String text, TextStyle? style, {bool isLast = false}) {
    return TextSpan(text: '\u2022  $text${isLast ? '' : '\n'}', style: style);
  }

  Widget _troubleshootingTips({required BuildContext context}) {
    final theme = context.theme;
    final (textTheme, colorScheme) = (theme.textTheme, theme.colorScheme);

    final itemStyle = textTheme.bodyMedium?.copyWith(
      height: 1.5,
      color: colorScheme.onSurfaceVariant,
    );
    final t = context
        .t
        .server
        .localNetworkDiscovery
        .noServersFound
        .doneScanning
        .troubleshootingTips;

    return ExpansionTile(
      title: Text(t.toggleButtonLabel),
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${t.title}\n',
                style: textTheme.titleSmall?.copyWith(height: 1.8),
              ),
              _bulletSpan(t.serverNotRunning, itemStyle),
              _bulletSpan(t.sameNetwork, itemStyle),
              _bulletSpan(t.refreshList, itemStyle),
              _bulletSpan(t.manualEntry, itemStyle),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final (textTheme, colorScheme) = (theme.textTheme, theme.colorScheme);

    final t = context.t.server.localNetworkDiscovery.noServersFound;

    final title = isLoading ? t.stillScanning.title : t.doneScanning.title;
    final subtitle = isLoading
        ? t.stillScanning.subtitle(appName: ProjectConstants.displayName)
        : t.doneScanning.subtitle(appName: ProjectConstants.displayName);

    return Column(
      mainAxisSize: .min,
      children: [
        Lottie.asset(
          isLoading ? Assets.lottie.radar.path : Assets.lottie.emptyResult.path,
          height: 120,
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(fontWeight: .w400),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: .center,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        if (!isLoading) ...[
          const SizedBox(height: 12),
          _troubleshootingTips(context: context),
          const SizedBox(height: 18),
          Tooltip(
            message: t.doneScanning.hostServerGuideButton.tooltip,
            child: SizedBox(
              child: FilledButton.icon(
                onPressed: () =>
                    launchUrl(Uri.parse(ProjectConstants.hostServerGuideLink)),
                label: Text(t.doneScanning.hostServerGuideButton.label),
                icon: const Icon(Icons.open_in_browser),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _DiscoveredServersList extends StatelessWidget {
  const _DiscoveredServersList({
    required this.isLoading,
    required this.discoveredServers,
  });

  final bool isLoading;
  final List<DiscoveredServer> discoveredServers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        // TODO: (MDNS) Better loading
        if (isLoading) const LinearProgressIndicator(),
        SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < discoveredServers.length; i++) ...[
                _ServerTile(server: discoveredServers[i], index: i),
                if (i != discoveredServers.length - 1) const Divider(),
              ],
            ],
          ),
        ),
      ],
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
        trailing: server.latencyMs == null
            ? null
            : Row(
                mainAxisSize: .min,
                children: [
                  Icon(
                    Icons.circle,
                    size: 10,
                    color: server.hasLowLatency ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 6),
                  Text('${server.latencyMs!} ms'),
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
        child: OutlinedButton(
          onPressed: () async {
            // TODO: (MDNS) Temporary prototype code!
            final selected = context
                .read<LocalDiscoveryCubit>()
                .state
                .selectedServerId;
            final messenger = ScaffoldMessenger.of(context);
            if (selected == null) {
              messenger.showSnackBar(
                const SnackBar(content: Text('Please select a server first')),
              );
              return;
            }
            final client = Client('http://$selected');
            try {
              final response = await client.handshake.check(
                HandshakeRequest(clientBuildNumber: Pubspec.versionBuildNumber),
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
          },
          child: Text(t.button),
        ),
      ),
      title: Text(t.title),
      subtitle: Text(t.subtitle),
    );
  }
}
