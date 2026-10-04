/// Heavily modified copy of Flutter's dart:io NetworkImage implementation.
///
/// Original source:
/// https://github.com/flutter/flutter/blob/d253af9e66c44477fa7a789780cc32d3ffbfe6f4/packages/flutter/lib/src/painting/_network_image_io.dart
library;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/file_storage/file_storage_repository.dart';
import 'package:librelab_shared/result.dart';

// Method signature for _loadAsync decode callbacks.
typedef _SimpleDecoderCallback = Future<ui.Codec> Function(
  ui.ImmutableBuffer buffer,
);

/// An [ImageProvider] for images stored in LibreLab's storage service.
///
/// Loads the image using the given storage object ID and integrates with
/// [FileStorageRepository] for authenticated requests and authentication refresh handling.
///
/// Authenticated image loading follows LibreLab's API authentication contract
/// rather than a generic download-URL model.
///
/// Throws [LibreLabStorageImageException] if the storage request fails.
///
/// Throws [LibreLabStorageImageEmptyFileException] if the storage request
/// succeeds but returns an empty file.
@immutable
class const LibreLabStorageImage({
  required final String storageObjectId,
  required final FileStorageRepository fileStorageRepository,

  /// A timestamp used to distinguish cached versions of the image.
  required final DateTime updatedAt,
  final double scale = 1.0,
}) extends ImageProvider<LibreLabStorageImage> {
  @override
  Future<LibreLabStorageImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<LibreLabStorageImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(
    LibreLabStorageImage key,
    ImageDecoderCallback decode,
  ) {
    // Ownership of this controller is handed off to [_loadAsync]; it is that
    // method's responsibility to close the controller's stream when the image
    // has been loaded or an error is thrown.
    final chunkEvents = StreamController<ImageChunkEvent>();

    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, chunkEvents, decode: decode),
      chunkEvents: chunkEvents.stream,
      scale: key.scale,
      debugLabel: key.storageObjectId,
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<ImageProvider>('Image provider', this),
        DiagnosticsProperty<LibreLabStorageImage>('Image key', key),
      ],
    );
  }

  Future<ui.Codec> _loadAsync(
    LibreLabStorageImage key,
    StreamController<ImageChunkEvent> chunkEvents, {
    required _SimpleDecoderCallback decode,
  }) async {
    try {
      assert(key == this, 'The image key must match the image provider.');

      final result = await fileStorageRepository.get(key.storageObjectId);

      switch (result) {
        case SuccessResult(value: final file):
          final builder = BytesBuilder(copy: false);
          var bytesLoaded = 0;

          await for (final chunk in file.stream) {
            builder.add(chunk);
            bytesLoaded += chunk.length;

            chunkEvents.add(
              ImageChunkEvent(
                cumulativeBytesLoaded: bytesLoaded,
                expectedTotalBytes: file.length,
              ),
            );
          }

          final bytes = builder.takeBytes();

          if (bytes.lengthInBytes == 0) {
            throw LibreLabStorageImageEmptyFileException(key.storageObjectId);
          }

          return await decode(await ui.ImmutableBuffer.fromUint8List(bytes));
        case FailureResult(:final failure):
          throw LibreLabStorageImageException(failure);
      }
    } catch (e) {
      // Depending on where the exception was thrown, the image cache may not
      // have had a chance to track the key in the cache at all.
      // Schedule a microtask to give the cache a chance to add the key.
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    } finally {
      unawaited(
        chunkEvents.close().catchError((Object error, StackTrace stack) {
          FlutterError.reportError(
            FlutterErrorDetails(
              exception: error,
              stack: stack,
              library: 'painting library',
              context: ErrorDescription(
                'while closing chunkEvents stream in LibreLabStorageImage.load',
              ),
            ),
          );
        }),
      );
    }
  }

  @override
  bool operator ==(Object other) {
    return other is LibreLabStorageImage &&
        other.storageObjectId == storageObjectId &&
        other.updatedAt == updatedAt &&
        other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(storageObjectId, updatedAt, scale);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'LibreLabStorageImage')}('
      '"$storageObjectId", '
      'updatedAt: $updatedAt, '
      'scale: ${scale.toStringAsFixed(1)})';
}

final class const LibreLabStorageImageException(final ApiRequestFailure failure)
    implements Exception {
  @override
  String toString() => 'LibreLabStorageImageException: $failure';
}

final class LibreLabStorageImageEmptyFileException(final String id)
    implements Exception {
  @override
  String toString() =>
      'LibreLabStorageImageEmptyFileException: Empty file for $id';
}
