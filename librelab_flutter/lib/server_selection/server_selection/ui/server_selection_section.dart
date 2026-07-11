import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_compatibility_check_card.dart';
import 'package:librelab_flutter/server_selection/compatibility/server_connection_info_card.dart';
import 'package:librelab_flutter/server_selection/server_address/server_address_text_field.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:librelab_flutter/server_selection/server_selection/ui/server_selection_method_container/server_selection_method_container.dart';

class const ServerSelectionSection({super.key}) extends StatefulWidget {
  @override
  State<ServerSelectionSection> createState() => _ServerSelectionSectionState();
}

class _ServerSelectionSectionState extends State<ServerSelectionSection> {
  final _formKey = GlobalKey<FormState>();
  final _serverAddressFocusNode = FocusNode();

  void _requestServerUrlFocus() {
    (_formKey.currentState ??
            (throw StateError('$Form state is not available')))
        .validate();

    _serverAddressFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ServerSelectionMethodContainer(
          formKey: _formKey,
          serverAddressFocusNode: _serverAddressFocusNode,
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

class const _ServerSelectionMethodContainer({
  required final FocusNode _serverAddressFocusNode,
  required final GlobalKey<FormState> _formKey,
}) extends StatelessWidget {
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
