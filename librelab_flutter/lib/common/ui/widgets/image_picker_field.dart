import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/image_picker_handler.dart';
import 'package:material_ui/material_ui.dart';

/// A form field that displays an image and allows it to be changed or removed.
class const ImagePickerField({
  super.key,
  required final ImageProvider<Object>? image,
  required final String fallbackCharacter,
  required final void Function(Uint8List bytes) onImagePicked,
  required final VoidCallback onImageRemoved,
  required final bool canEdit,
}) extends StatelessWidget {
  Future<void> _pickImage(BuildContext context) async {
    final bytes = await ImagePickerHandler(ImagePicker()).pickImage(context);
    if (bytes == null) {
      return;
    }
    onImagePicked(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    return Stack(
      clipBehavior: .none,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: .circular(28),
            image: image == null
                ? null
                : DecorationImage(image: image!, fit: .cover),
          ),
          alignment: .center,
          child: image == null
              ? Text(
                  fallbackCharacter,
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
        ),
        if (canEdit)
          Positioned(
            right: -8,
            bottom: -8,
            child: MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () => _pickImage(context),
                  child: Text(context.t.imagePicker.changeImage),
                ),
                if (image != null)
                  MenuItemButton(
                    onPressed: onImageRemoved,
                    child: Text(context.t.imagePicker.removeImage),
                  ),
              ],
              builder: (context, controller, child) {
                return IconButton.filled(
                  onPressed: () {
                    if (image == null) {
                      _pickImage(context);
                      return;
                    }

                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: Icon(Icons.edit, color: colorScheme.onPrimary),
                );
              },
            ),
          ),
      ],
    );
  }
}
