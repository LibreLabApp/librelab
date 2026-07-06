import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_shared/librelab_shared.dart';

class const ServerAddressTextField({
  super.key,
  required final String _initialValue,
  required final void Function(String value) _onChanged,
  required final FocusNode _focusNode,
}) extends StatefulWidget {
  @override
  State<ServerAddressTextField> createState() => _ServerAddressTextFieldState();
}

class _ServerAddressTextFieldState extends State<ServerAddressTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();

    widget._focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  void initState() {
    _controller.text = widget._initialValue;
    _controller.addListener(_onChanged);

    widget._focusNode.addListener(_onFocusChange);
    super.initState();
  }

  void _onFocusChange() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      return;
    }

    final normalized = prependsHttpsIfNoScheme(text);

    if (normalized != text) {
      _controller.value = TextEditingValue(
        text: normalized,
        selection: TextSelection.collapsed(offset: normalized.length),
      );
    }
  }

  /// Note: This subscribes to [_controller] changes instead of relying on
  /// [TextField.onChanged], so updates are captured for both user input and
  /// programmatic assignments (e.g., `controller.text = ...`).
  void _onChanged() {
    widget._onChanged(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.serverSelection.manualAddress.textField;
    return TextFormField(
      controller: _controller,
      maxLines: 1,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: const [AutofillHints.url],
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      focusNode: widget._focusNode,
      validator: (value) {
        final validationErrorMessages = t.validationErrors;

        final input = value?.trim();
        if (input == null || input.isEmpty) {
          return validationErrorMessages.emptyInput;
        }
        final normalizedInput = prependsHttpsIfNoScheme(input);

        return switch (validateHttpUrl(normalizedInput)) {
          null => null,
          InvalidUri() => validationErrorMessages.invalidUri,
          MissingScheme() => validationErrorMessages.missingScheme,
          UnsupportedScheme(:final scheme) =>
            validationErrorMessages.unsupportedScheme(scheme: scheme),
          MissingAuthority() => validationErrorMessages.missingHost,
          MissingHost() => validationErrorMessages.missingHost,
          InvalidPort(:final port) => validationErrorMessages.invalidPort(
            port: port,
          ),
        };
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.dns),
        border: const OutlineInputBorder(),
        hintText: t.hint,
        labelText: t.label,
        helperText: t.helper,
        suffixIcon: ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, value, _) {
            if (value.text.isEmpty) {
              return Tooltip(
                constraints: const BoxConstraints(maxWidth: 300),
                message: t.infoTooltip,
                child: const Icon(Icons.info_outline),
              );
            }
            return IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _controller.clear,
            );
          },
        ),
      ),
    );
  }
}
