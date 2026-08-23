import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/copy_error_details_snackbar_action.dart';
import 'package:librelab_flutter/common/ui/widgets/cubit_effect_listener.dart';
import 'package:librelab_flutter/login_identity/cubit/login_identity_cubit.dart';
import 'package:material_ui/material_ui.dart';

class const LogoutIconButton({super.key, required final String tooltip})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (LoginIdentityCubit v) => v.state.logoutState.isLoading,
    );

    return _LoginIdentityEffectListener(
      child: isLoading
          ? const CircularProgressIndicator()
          : IconButton(
              onPressed: () => context.read<LoginIdentityCubit>().logout(),
              icon: const Icon(Icons.logout),
              tooltip: tooltip,
            ),
    );
  }
}

class const LogoutConfirmationDialog({
  super.key,
  required final bool loginDisabled,
}) extends StatefulWidget {
  @override
  State<LogoutConfirmationDialog> createState() =>
      _LogoutConfirmationDialogState();
}

class _LogoutConfirmationDialogState extends State<LogoutConfirmationDialog> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t.homePage.actions.logout.confirmationDialog;

    return AlertDialog(
      title: Text(
        widget.loginDisabled ? t.loginDisabled.title : t.loginEnabled.title,
      ),
      content: Column(
        mainAxisSize: .min,
        children: [
          Text(
            widget.loginDisabled
                ? t.loginDisabled.subtitle
                : t.loginEnabled.subtitle,
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _confirmed,
            onChanged: (value) => setState(() => _confirmed = value ?? false),
            contentPadding: .zero,
            title: Text(
              widget.loginDisabled
                  ? t.loginDisabled.confirmationCheckbox
                  : t.loginEnabled.confirmationCheckbox,
            ),
            controlAffinity: .leading,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(t.cancel),
        ),
        FilledButton(
          onPressed: _confirmed ? () => Navigator.of(context).pop(true) : null,
          child: Text(t.confirm),
        ),
      ],
    );
  }
}

/// Handles login identity effects that require UI interaction.
class const _LoginIdentityEffectListener({required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitEffectListener<
      LoginIdentityCubit,
      LoginIdentityState,
      LoginIdentityEffect
    >(
      listener: (context, effect) async {
        switch (effect) {
          case LogoutConfirmationRequired():
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => LogoutConfirmationDialog(
                loginDisabled: effect.isLoginDisabled,
              ),
            );

            if (confirmed != true || !context.mounted) {
              return;
            }

            await context.read<LoginIdentityCubit>().logout(
              confirmLogout: true,
            );

          case LogoutFailureMessage(:final failure):
            context.showSnackBarMessage(
              context.t.homePage.actions.logout.logoutFailure,
              action: CopyErrorDetailsSnackBarAction(
                context: context,
                failureDetails: failure.message,
              ),
            );
        }
      },
      child: child,
    );
  }
}
