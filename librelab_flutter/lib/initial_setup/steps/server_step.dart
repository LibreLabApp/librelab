import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/alert_card.dart';
import 'package:librelab_flutter/common/build_context_ext.dart';
import 'package:librelab_flutter/initial_setup/cubit/initial_setup_cubit.dart';

class InitialSetupServerStep extends StatelessWidget {
  const InitialSetupServerStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Adds top padding so the floating label of the first outlined TextField isn’t clipped inside PageView
        const SizedBox(height: 4),
        const _ServerSelection(),
        const SizedBox(height: 18),
        AlertCard(
          type: .note,
          prefixIcon: Icons.wifi,
          suffix: Padding(
            padding: const EdgeInsetsGeometry.only(left: 16, top: 16),
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Test Connection'),
            ),
          ),
          title: const Text('Test your connection'),
          subtitle: const Text(
            'Make sure you can connect to your server before continuing.',
          ),
        ),
      ],
    );
  }
}

enum _ServerSelectionMode { localNetwork, manual }

class _ServerSelection extends StatefulWidget {
  const _ServerSelection();

  @override
  State<_ServerSelection> createState() => _ServerSelectionState();
}

class _ServerSelectionState extends State<_ServerSelection> {
  _ServerSelectionMode _mode = .localNetwork;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: .infinity,
          child: SegmentedButton<_ServerSelectionMode>(
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
            segments: _ServerSelectionMode.values
                .map<ButtonSegment<_ServerSelectionMode>>(
                  (e) => switch (e) {
                    _ServerSelectionMode.localNetwork => const ButtonSegment(
                      value: .localNetwork,
                      label: Text('Find on Network'),
                      icon: Icon(Icons.wifi),
                      tooltip: '',
                    ),
                    _ServerSelectionMode.manual => const ButtonSegment(
                      value: .manual,
                      label: Text('Enter Server Address'),
                      icon: Icon(Icons.public),
                    ),
                  },
                )
                .toList(),
            selected: {_mode},
          ),
        ),
        const SizedBox(height: 16),
        switch (_mode) {
          _ServerSelectionMode.localNetwork =>
            const _ServerAddressLocalNetwork(),
          _ServerSelectionMode.manual => const _ServerAddressTextField(),
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
                    'Base address of the server used to connect the app and sync data across devices. It can be provided by a service administrator or configured for a self-hosted setup.',
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
  // TODO: Replace with the real servers and load
  static final _dummyServers = <_LocalNetworkServer>[
    const _LocalNetworkServer(
      name: 'LibreLab Server',
      address: 'http://192.168.1.45:8080',
      ping: 3,
      isFast: true,
    ),
    const _LocalNetworkServer(
      name: 'LibreLab Server 2',
      address: 'http://192.168.1.88:8080',
      ping: 8,
      isFast: true,
    ),
    const _LocalNetworkServer(
      name: 'LibreLab Office',
      address: 'http://192.168.1.120:8080',
      ping: 100,
      isFast: false,
    ),
  ];
  int _selectedServerIndex = 0;

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
                'Available Servers',
                style: textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(textStyle: textTheme.titleMedium),
                onPressed: () {},
                label: const Text('Refresh'),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView(
              children: _dummyServers.map((e) {
                final i = _dummyServers.indexOf(e);
                return RadioGroup(
                  onChanged: (value) => setState(
                    () => _selectedServerIndex =
                        value ??
                        (throw throw StateError(
                          'New RadioGroup value cannot be null',
                        )),
                  ),
                  groupValue: _selectedServerIndex,
                  child: ListTile(
                    onTap: () => setState(() => _selectedServerIndex = i),
                    title: Text(e.name),
                    subtitle: Text(e.address),
                    leading: Row(
                      mainAxisSize: .min,
                      spacing: 8,
                      children: [
                        Radio(value: i),
                        const Icon(Icons.dns),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: .min,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: e.isFast ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 6),
                        Text('${e.ping} ms'),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select a server found on your local network',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocalNetworkServer {
  const _LocalNetworkServer({
    required this.name,
    required this.address,
    required this.ping,
    required this.isFast,
  });

  final String name;
  final String address;
  final int ping;
  final bool isFast;
}
