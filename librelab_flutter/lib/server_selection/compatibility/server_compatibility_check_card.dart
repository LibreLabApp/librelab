import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/ui/api_request_failure_ui_messages.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/alert_card.dart';
import 'package:librelab_flutter/server_selection/server_selection/cubit/server_selection_cubit.dart';

typedef _RequestServerUrlFocus = void Function();

/// A card that triggers an API server compatibility check via an action button.
///
/// Verifies that a selected server is reachable and
/// compatible with the current app version.
class const ServerCompatibilityCheckCard({
  super.key,
  required final _RequestServerUrlFocus _requestServerUrlFocus,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = context.t.serverCompatibility.check;

    final state = context.select(
      (ServerSelectionCubit v) => v.state.compatibilityCheckState,
    );
    final isLoading = state is Load;

    final compatibilityStatus = t.success.compatibilityStatus;
    final (String title, String subtitle) strings = switch (state) {
      Initial() => (t.idle.title, t.idle.subtitle),
      Load() => (t.loading.title, t.loading.subtitle),
      Success(:final response) => (switch (response.status) {
        .fullyCompatible => (
          compatibilityStatus.fullyCompatible.title,
          compatibilityStatus.fullyCompatible.subtitle,
        ),
        .compatible => (
          compatibilityStatus.compatible.title,
          compatibilityStatus.compatible.subtitle,
        ),
        .updateClient => (
          compatibilityStatus.updateClient.title,
          compatibilityStatus.updateClient.subtitle,
        ),
        .updateServer => (
          compatibilityStatus.updateServer.title,
          compatibilityStatus.updateServer.subtitle,
        ),
      }),
      Failure(:final failure) => (
        t.failure.title,
        failure.getUiMessage(context.t),
      ),
    };
    final (title, subtitle) = strings;

    return AlertCard(
      type: switch (state) {
        Initial() => .note,
        Load() => .note,
        Success(:final response) =>
          response.status.isCompatible ? .success : .error,
        Failure() => .error,
      },
      prefixIcon: Icons.wifi,
      suffix: (color) => Padding(
        padding: const EdgeInsetsGeometry.only(left: 16, top: 16),
        child: _ServerSelectionEffectListener(
          requestServerUrlFocus: _requestServerUrlFocus,
          child: Builder(
            builder: (context) {
              final hasNotSelectedServer = context.select((
                ServerSelectionCubit v,
              ) {
                final state = v.state;

                final selectionMethod = state.selectionMethod;
                final hasSelectedDiscoveredServer =
                    state.discoveryState.selectedServerId != null;

                return selectionMethod == .localNetworkDiscovery &&
                    !hasSelectedDiscoveredServer;
              });

              final shouldDisableButton = hasNotSelectedServer || isLoading;

              if (isLoading) {
                return const CircularProgressIndicator();
              }

              return Tooltip(
                message: hasNotSelectedServer
                    ? t.button.serverSelectionRequired
                    : '',
                child: OutlinedButton(
                  onPressed: shouldDisableButton
                      ? null
                      : () => context
                            .read<ServerSelectionCubit>()
                            .checkServerCompatibility(),
                  style: OutlinedButton.styleFrom(foregroundColor: color),
                  child: Text(t.button.label),
                ),
              );
            },
          ),
        ),
      ),
      title: Text(title),
      subtitle: Tooltip(
        constraints: const BoxConstraints(maxWidth: 300),
        message: () {
          if (state is Failure) {
            return state.failure.message;
          }
          if (state is Success) {
            return t.success.serverConnectionDetailsTooltip(
              version: state.response.serverVersion,
              buildNumber: state.response.serverBuildNumber,
              serverUrl: state.uri.toString(),
            );
          }
          return '';
        }(),
        child: Text(subtitle),
      ),
    );
  }
}

// TODO: Refactor to be reusable
class const _ServerSelectionEffectListener({
  required final _RequestServerUrlFocus _requestServerUrlFocus,
  required final Widget child,
}) extends StatefulWidget {
  @override
  State<_ServerSelectionEffectListener> createState() =>
      _ServerSelectionEffectListenerState();
}

class _ServerSelectionEffectListenerState
    extends State<_ServerSelectionEffectListener> {
  late final StreamSubscription<ServerSelectionEffect> _effectSubscription;

  @override
  void initState() {
    final cubit = context.read<ServerSelectionCubit>();

    _effectSubscription = cubit.effects.listen((effect) {
      switch (effect) {
        case FocusServerAddress():
          widget._requestServerUrlFocus();

        case ShowServerSelectionRequired():
          final context = this.context;
          if (context.mounted) {
            context.showSnackBarMessage(
              context
                  .t
                  .serverCompatibility
                  .check
                  .button
                  .serverSelectionRequired,
            );
          }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _effectSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
