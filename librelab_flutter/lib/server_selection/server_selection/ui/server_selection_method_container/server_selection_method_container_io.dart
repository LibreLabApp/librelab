import 'package:flutter/material.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/server_selection/local_network_discovery/local_server_discovery_card.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';

Widget builderServerSelectionMethodContainer(
  BuildContext context,
  ServerSelectionMethod selectedMethod,
  ServerSelectionCubit cubit, {
  required Form Function() serverAddressTextField,
}) {
  return Column(
    children: [
      SizedBox(width: .infinity, child: _methodSelector(cubit, selectedMethod)),
      const SizedBox(height: 16),
      _body(
        cubit,
        selectedMethod,
        serverAddressTextField: serverAddressTextField,
      ),
    ],
  );
}

Widget _methodSelector(
  ServerSelectionCubit cubit,
  ServerSelectionMethod method,
) => _ServerSelectionModeSegmentedButtons(
  selected: method,
  onSelectionChanged: (value) => cubit.setSelectionMethod(value.first),
);

Widget _body(
  ServerSelectionCubit cubit,
  ServerSelectionMethod method, {
  required Form Function() serverAddressTextField,
}) => switch (method) {
  .localNetworkDiscovery => const LocalServerDiscoveryCard(),
  .manual => serverAddressTextField(),
  .useWebAppServer => throw _webUnsupported(),
};

class const _ServerSelectionModeSegmentedButtons({
  required final ServerSelectionMethod _selected,
  required final void Function(Set<ServerSelectionMethod>) _onSelectionChanged,
}) extends StatefulWidget {
  @override
  State<_ServerSelectionModeSegmentedButtons> createState() =>
      _ServerSelectionModeSegmentedButtonsState();
}

UnsupportedError _webUnsupported() => UnsupportedError(
  '${ServerSelectionMethod.useWebAppServer.name} is unsupported in this implementation.\n'
  'This file must be only imported on non-web platforms',
);

class _ServerSelectionModeSegmentedButtonsState
    extends State<_ServerSelectionModeSegmentedButtons> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ServerSelectionMethod>(
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
        tapTargetSize: .padded,
      ),
      onSelectionChanged: widget._onSelectionChanged,
      segments:
          (ServerSelectionMethod.values.toList()
                ..removeWhere((e) => e == .useWebAppServer))
              .map<ButtonSegment<ServerSelectionMethod>>((e) {
                final t = context.t.serverSelection;
                final label = switch (e) {
                  .localNetworkDiscovery => t.localNetworkDiscovery.button,
                  .manual => t.manualAddress.button,
                  .useWebAppServer => throw _webUnsupported(),
                };
                final icon = switch (e) {
                  .localNetworkDiscovery => Icons.wifi,
                  .manual => Icons.public,
                  .useWebAppServer => throw _webUnsupported(),
                };
                final tooltip = switch (e) {
                  .localNetworkDiscovery => t.localNetworkDiscovery.tooltip,
                  .manual => t.manualAddress.tooltip,
                  .useWebAppServer => throw _webUnsupported(),
                };

                return ButtonSegment(
                  value: e,
                  label: Text(label),
                  icon: Icon(icon),
                  tooltip: tooltip,
                );
              })
              .toList(),
      selected: {widget._selected},
    );
  }
}
