import 'package:flutter/material.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:go_router/go_router.dart';
import 'package:librelab_flutter/common/build_context_ext.dart';
import 'package:librelab_flutter/common/platform/platform_check.dart';

void setupWindowCloseHandler(BuildContext context) {
  if (!isDesktop) {
    throw UnsupportedError(
      'setupWindowCloseHandler() must not be called on non-desktop platforms.',
    );
  }
  FlutterWindowClose.setWindowShouldCloseHandler(() => _handler(context));
}

/// Prevents multiple exit confirmation dialogs from appearing simultaneously.
///
/// If the user repeatedly clicks the window close button while a dialog
/// is already visible, subsequent attempts are ignored.
bool _isDialogOpen = false;

Future<bool> _handler(BuildContext context) async {
  if (_isDialogOpen) {
    return false;
  }
  _isDialogOpen = true;

  final shouldExit = await showDialog<bool>(
    context: context,
    builder: (context) {
      return const _ConfirmExitDialog();
    },
  );
  return shouldExit ?? false;
}

class _ConfirmExitDialog extends StatefulWidget {
  const _ConfirmExitDialog();

  @override
  State<_ConfirmExitDialog> createState() => _ConfirmExitDialogState();
}

class _ConfirmExitDialogState extends State<_ConfirmExitDialog> {
  bool _shouldBackup = false;

  void _closeDialog(bool result) {
    _isDialogOpen = false;
    context.pop(result);
  }

  @override
  void dispose() {
    _isDialogOpen = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    return AlertDialog(
      title: Text(context.t.confirmProgramExitDialog.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Text(context.t.confirmProgramExitDialog.message),
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(context.t.confirmProgramExitDialog.backupCheckbox),
            value: _shouldBackup,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              setState(() => _shouldBackup = value ?? false);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => _closeDialog(false),
          child: Text(context.t.confirmProgramExitDialog.cancelButton),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.errorContainer,
            foregroundColor: colorScheme.onErrorContainer,
          ),
          onPressed: () {
            if (_shouldBackup) {
              // TODO: Not implement yet
            }
            _closeDialog(true);
          },
          child: Text(context.t.confirmProgramExitDialog.confirmButton),
        ),
      ],
    );
  }
}
