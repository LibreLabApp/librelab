import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_compatibility_check_card.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_connection_info_card.dart';
import 'package:librelab_flutter/server_selection/local_network_discovery/local_server_discovery_card.dart';
import 'package:librelab_flutter/server_selection/server_address/server_address_text_field.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';

class ServerSelectionSection extends StatelessWidget {
  ServerSelectionSection({super.key});

  final _serverSelectionMethodContainerKey =
      GlobalKey<_ServerSelectionMethodContainerState>();

  void _requestServerUrlFocus() {
    final state =
        _serverSelectionMethodContainerKey.currentState ??
        (throw StateError(
          '$_ServerSelectionMethodContainer state is not available.',
        ));

    (state._formKey.currentState ??
            (throw StateError('$Form state is not available')))
        .validate();

    state._serverAddressFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ServerSelectionMethodContainer(
          key: _serverSelectionMethodContainerKey,
        ),
        const SizedBox(height: 18),
        ServerCompatibilityCheckCard(
          requestServerUrlFocus: _requestServerUrlFocus,
        ),
        Builder(
          builder: (context) {
            final compatibilityCheckState = context.select(
              (ServerSelectionCubit v) => v.state.compatibilityCheckState,
            );
            if (compatibilityCheckState is! Success) {
              return const SizedBox.shrink();
            }
            final uri = compatibilityCheckState.uri;
            final type = ServerConnectionInfoCard.getNoticeType(uri);

            if (type == null) {
              return const SizedBox.shrink();
            }
            return ServerConnectionInfoCard(
              type: type,
              uri: compatibilityCheckState.uri,
            );
          },
        ),
      ],
    );
  }
}

class const _ServerSelectionMethodContainer({super.key})
    extends StatefulWidget {
  @override
  State<_ServerSelectionMethodContainer> createState() =>
      _ServerSelectionMethodContainerState();
}

class _ServerSelectionMethodContainerState
    extends State<_ServerSelectionMethodContainer> {
  final _formKey = GlobalKey<FormState>();
  final _serverAddressFocusNode = FocusNode();

  @override
  void dispose() {
    _serverAddressFocusNode.dispose();
    super.dispose();
  }

  Widget _methodSelector(
    ServerSelectionCubit cubit,
    ServerSelectionMethod method,
  ) => _ServerSelectionModeSegmentedButtons(
    selected: method,
    onSelectionChanged: (value) => cubit.setSelectionMethod(value.first),
  );

  Widget _body(ServerSelectionCubit cubit, ServerSelectionMethod method) =>
      switch (method) {
        .localNetworkDiscovery => const LocalServerDiscoveryCard(),
        .manual => Form(
          key: _formKey,
          autovalidateMode: .onUserInteraction,
          child: ServerAddressTextField(
            initialValue: cubit.state.manualServerAddress ?? '',
            onChanged: (value) => cubit.setManualServerAddress(value),
            focusNode: _serverAddressFocusNode,
          ),
        ),
      };

  @override
  Widget build(BuildContext context) {
    final selectedMethod = context.select(
      (ServerSelectionCubit v) => v.state.selectionMethod,
    );
    final cubit = context.read<ServerSelectionCubit>();

    return Column(
      children: [
        /// Server selection controls are omitted on web due to lack of
        /// native mDNS service discovery support.
        if (!kIsWeb)
          SizedBox(
            width: .infinity,
            child: _methodSelector(cubit, selectedMethod),
          ),
        const SizedBox(height: 16),
        _body(cubit, selectedMethod),
      ],
    );
  }
}

class _ServerSelectionModeSegmentedButtons extends StatefulWidget {
  const _ServerSelectionModeSegmentedButtons({
    required this.selected,
    required this.onSelectionChanged,
  });

  final ServerSelectionMethod selected;
  final void Function(Set<ServerSelectionMethod>) onSelectionChanged;

  @override
  State<_ServerSelectionModeSegmentedButtons> createState() =>
      _ServerSelectionModeSegmentedButtonsState();
}

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
      onSelectionChanged: widget.onSelectionChanged,
      segments: ServerSelectionMethod.values
          .map<ButtonSegment<ServerSelectionMethod>>((e) {
            final t = context.t.serverSelection;
            final label = switch (e) {
              .localNetworkDiscovery => t.localNetworkDiscovery.button,
              .manual => t.manualAddress.button,
            };
            final icon = switch (e) {
              .localNetworkDiscovery => Icons.wifi,
              .manual => Icons.public,
            };
            final tooltip = switch (e) {
              .localNetworkDiscovery => t.localNetworkDiscovery.tooltip,
              .manual => t.manualAddress.tooltip,
            };

            return ButtonSegment(
              value: e,
              label: Text(label),
              icon: Icon(icon),
              tooltip: tooltip,
            );
          })
          .toList(),
      selected: {widget.selected},
    );
  }
}
