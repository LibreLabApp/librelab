import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';

import 'package:mime/mime.dart';

@immutable
class const PickedImage({
  /// The file's contents.
  required final Uint8List bytes,
  required final int length,
  required final String name,
  required final String mimeType,
});

/// Handles image selection for the UI.
///
/// Selected images are read into memory using [XFile.readAsBytes], which is
/// appropriate for the small image files supported by this handler. It is not
/// intended as a general-purpose file picker.
class ImagePickerHandler(final ImagePicker _imagePicker) {
  final _logger = Logger('ImagePickerHandler');

  static const _maxImageFileSize = FileUploadLimits.maxImageSizeBytes;
  static const _maxImageFileSizeText =
      '${_maxImageFileSize ~/ (1024 * 1024)} MB';

  Future<PickedImage?> pickImage(BuildContext context) async {
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

    final mimeType = file.mimeType ?? lookupMimeType(file.path);
    if (mimeType == null) {
      if (context.mounted) {
        context.showSnackBarMessage(t.missingMimeType);
      }
      return null;
    }

    // TODO: Decide when to use "fileSize" and when to use "fileBytes" when naming,
    //  and rename existing symbol names for consistency (across the entire codebase)
    final fileLength = await file.length();
    if (fileLength > _maxImageFileSize) {
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

    return .new(
      bytes: fileBytes,
      length: fileLength,
      name: file.name,
      mimeType: mimeType,
    );
  }
}
