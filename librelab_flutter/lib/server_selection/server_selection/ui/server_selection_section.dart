import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_compatibility_check_card.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_connection_info_card.dart';
import 'package:librelab_flutter/server_selection/server_address/server_address_text_field.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:librelab_flutter/server_selection/server_selection/ui/server_selection_method_container/server_selection_method_container.dart';

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

  Form _serverAddressTextField(ServerSelectionCubit cubit) => Form(
    key: _formKey,
    autovalidateMode: .onUserInteraction,
    child: ServerAddressTextField(
      initialValue: cubit.state.manualServerAddress ?? '',
      onChanged: (value) => cubit.setManualServerAddress(value),
      focusNode: _serverAddressFocusNode,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final selectedMethod = context.select(
      (ServerSelectionCubit v) => v.state.selectionMethod,
    );
    final cubit = context.read<ServerSelectionCubit>();

    return builderServerSelectionMethodContainer(
      context,
      selectedMethod,
      cubit,
      serverAddressTextField: () => _serverAddressTextField(cubit),
    );
  }
}
