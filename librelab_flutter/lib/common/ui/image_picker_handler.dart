import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:logging/logging.dart';

class ImagePickerHandler(final ImagePicker _imagePicker) {
  final _logger = Logger('ImagePickerHandler');

  static const _maxImageFileSize = 5 * 1024 * 1024; // 5 MiB
  static const _maxImageFileSizeText =
      '${_maxImageFileSize ~/ (1024 * 1024)} MB';

  Future<Uint8List?> pickImage(BuildContext context) async {
    final t = context.t.filePicker;

    XFile? file;
    try {
      file = await _imagePicker.pickImage(source: .gallery);
      if (file == null) {
        return null;
      }
    } on Exception catch (e, stackTrace) {
      _logger.shout('Failed to pick an image.', e, stackTrace);

      if (context.mounted) {
        context.showSnackBarMessage(t.pickFailure);
      }

      return null;
    }

    final fileSize = await file.length();
    if (fileSize > _maxImageFileSize) {
      if (context.mounted) {
        context.showSnackBarMessage(
          t.exceedsMaximumSize(maxSize: _maxImageFileSizeText),
        );
      }
      return null;
    }

    Uint8List fileBytes;
    try {
      fileBytes = await file.readAsBytes();
    } on Exception catch (e, stackTrace) {
      _logger.shout('Failed to read the selected image.', e, stackTrace);

      if (context.mounted) {
        context.showSnackBarMessage(t.readFailure);
      }

      return null;
    }

    return fileBytes;
  }
}
