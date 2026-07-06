import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/generated/assets.gen.dart';
import 'package:librelab_flutter/server_selection/local_network_discovery/discovered_server.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

LocalNetworkDiscoveryController _localNetworkDiscoveryController(
  BuildContext context,
) => context.read<ServerSelectionCubit>().localNetworkDiscovery;

/// Unsupported on web due to lack of native mDNS service discovery.
class const LocalServerDiscoveryCard({super.key}) extends StatefulWidget {
  @override
  State<LocalServerDiscoveryCard> createState() =>
      _LocalServerDiscoveryCardState();
}

class _LocalServerDiscoveryCardState extends State<LocalServerDiscoveryCard> {
  @override
  void initState() {
    if (kIsWeb) {
      throw UnsupportedError(
        '$LocalServerDiscoveryCard widget must not be used on the web',
      );
    }
    _localNetworkDiscoveryController(context).scan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      throw UnsupportedError(
        '$LocalServerDiscoveryCard widget must not be used on the web',
      );
    }

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
            (ServerSelectionCubit v) =>
                v.state.discoveryState.discoveredServers,
          );
          final isLoading = context.select(
            (ServerSelectionCubit v) => v.state.discoveryState.isLoading,
          );

          final hasNoServers = discoveredServers.isEmpty;

          final t = context.t.serverSelection;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.localNetworkDiscovery.serverListTitle,
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
                        : () => _localNetworkDiscoveryController(
                            context,
                          ).scan(refresh: true),
                    label: Text(t.localNetworkDiscovery.refreshServersButton),
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
                        t.localNetworkDiscovery.discoveredServerPrompt,
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
                              t.localNetworkDiscovery.discoveredServersCount(
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
        .serverSelection
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

    final t = context.t.serverSelection.localNetworkDiscovery.noServersFound;

    final title = isLoading ? t.stillScanning.title : t.doneScanning.title;
    final subtitle = isLoading
        ? t.stillScanning.subtitle(appName: ProjectConstants.displayName)
        : t.doneScanning.subtitle(appName: ProjectConstants.displayName);

    return Column(
      mainAxisSize: .min,
      children: [
        Lottie.asset(
          isLoading ? Assets.lottie.radar : Assets.lottie.emptyResult,
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
        SizedBox(
          height: 4,
          child: isLoading ? const LinearProgressIndicator() : null,
        ),
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

enum _ServerTileAction { copyIpAddressEndpoint, copyLocalHostnameEndpoint }

class const _ServerTile({
  required final DiscoveredServer server,
  required final int index,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedServerId = context.select(
      (ServerSelectionCubit c) => c.state.discoveryState.selectedServerId,
    );
    final t = context.t.serverSelection.localNetworkDiscovery.tile;

    return RadioGroup<String>(
      onChanged: (newId) =>
          _localNetworkDiscoveryController(context).selectServer(newId),
      groupValue: selectedServerId,
      child: MenuAnchor(
        menuChildren: _ServerTileAction.values
            .map(
              (e) => MenuItemButton(
                onPressed:
                    e == .copyIpAddressEndpoint && server.ipAddress == null
                    ? null
                    : () {
                        final host = switch (e) {
                          .copyIpAddressEndpoint => server.ipAddress,
                          .copyLocalHostnameEndpoint => server.localHostname,
                        };
                        Clipboard.setData(
                          ClipboardData(text: '$host:${server.port}'),
                        );
                      },
                child: Text(switch (e) {
                  .copyIpAddressEndpoint => t.menu.copyIpAddressEndpoint,
                  .copyLocalHostnameEndpoint =>
                    t.menu.copyLocalHostnameEndpoint,
                }),
              ),
            )
            .toList(),
        builder: (context, controller, child) {
          return GestureDetector(
            onLongPressStart: (details) {
              if (controller.isOpen) {
                controller.close();
                return;
              }
              final box = context.findRenderObject()! as RenderBox;
              final local = box.globalToLocal(details.globalPosition);

              controller.open(position: local);
            },
            child: child,
          );
        },
        child: ListTile(
          onTap: () =>
              _localNetworkDiscoveryController(context).selectServer(server.id),
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
          trailing: () {
            final latencyMs = server.latencyMs;
            if (latencyMs == null) {
              return null;
            }
            return Row(
              mainAxisSize: .min,
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: server.hasLowLatency ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 6),
                Text(t.serverConnectionLatency(latencyMs: latencyMs)),
              ],
            );
          }(),
        ),
      ),
    );
  }
}
