import 'package:flutter/widgets.dart';

/// Groups a [TextEditingController] and [FocusNode] for a text field.
class TextFieldState {
  new({String? initialText})
    : controller = .new(text: initialText),
      focusNode = .new();

  final TextEditingController controller;
  final FocusNode focusNode;

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }
}
