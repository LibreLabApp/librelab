import 'package:image_picker/image_picker.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/image_picker_handler.dart';
import 'package:librelab_flutter/common/ui/widgets/failure/technical_failure_details_dialog.dart';
import 'package:material_ui/material_ui.dart';

/// A form field that displays an image and allows it to be changed or removed.
class const ImagePickerField({
  super.key,
  required final ImageProvider<Object>? image,
  required final String fallbackCharacter,
  required final void Function(PickedImage pickedImage) onImagePicked,
  required final VoidCallback onImageRemoved,
  required final bool canEdit,
}) extends StatefulWidget {
  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  Future<void> _pickImage(BuildContext context) async {
    final pickedImage = await ImagePickerHandler(ImagePicker())
        .pickImage(context);
    if (pickedImage == null) {
      return;
    }
    widget.onImagePicked(pickedImage);
  }

  /// Error encountered while loading the image.
  (Object, StackTrace?)? _imageError;

  void _handleImageError(Object exception, StackTrace? stackTrace) {
    if (_imageError?.$1 == exception && _imageError?.$2 == stackTrace) {
      return;
    }

    setState(() {
      _imageError = (exception, stackTrace);
    });
  }

  Future<void> _retryImage() async {
    await widget.image?.evict();

    if (!mounted) {
      return;
    }

    setState(() => _imageError = null);
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
            image: switch (widget.image) {
              final image? => DecorationImage(
                image: image,
                fit: .cover,
                onError: _handleImageError,
              ),
              null => null,
            },
          ),
          alignment: .center,
          child: () {
            if (widget.image == null) {
              return Text(
                widget.fallbackCharacter,
                style: theme.textTheme.displayLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              );
            }
            final imageError = _imageError;
            if (imageError != null) {
              final details = imageError.$1.toString();

              return Column(
                mainAxisSize: .min,
                children: [
                  Text(context.t.imagePicker.failedToLoadImage),
                  TextButton(
                    onPressed: _retryImage,
                    child: Text(context.t.retry),
                  ),
                  TextButton(
                    onPressed: () => TechnicalFailureDetailsDialog.show(
                      context,
                      details: details,
                    ),
                    child: Text(context.t.technicalFailureDetails.showDialog),
                  ),
                ],
              );
            }
            return null;
          }(),
        ),
        if (widget.canEdit)
          Positioned(
            right: -8,
            bottom: -8,
            child: MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () => _pickImage(context),
                  child: Text(context.t.imagePicker.changeImage),
                ),
                if (widget.image != null)
                  MenuItemButton(
                    onPressed: widget.onImageRemoved,
                    child: Text(context.t.imagePicker.removeImage),
                  ),
              ],
              builder: (context, controller, child) {
                return IconButton.filled(
                  onPressed: () {
                    if (widget.image == null) {
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
