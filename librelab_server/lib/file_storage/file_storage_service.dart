import 'dart:async';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:file/file.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object_repository.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

enum StorageArea {
  uploads,
  backups;

  String get directoryName => switch (this) {
    .uploads => 'uploads',
    .backups => 'backups',
  };
}

@immutable
class const StoredFile({
  required final StorageObject storageObject,
  required final Stream<List<int>> content,
});

class FileStorageService({
  required final StorageObjectRepository _storageObjectRepository,
  required final FileSystem _fileSystem,
  required String storageDirectoryPath,
}) {
  final Directory _storageDirectory = _fileSystem.directory(
    storageDirectoryPath,
  );

  /// Opens a stored file for reading by its storage object ID.
  ///
  /// Returns `null` if the storage object does not exist.
  Future<StoredFile?> open(String id) async {
    final storageObject = await _storageObjectRepository.findById(id);
    if (storageObject == null) {
      return null;
    }

    final file = _fileFor(storageKey: storageObject.storageKey);

    return .new(storageObject: storageObject, content: file.openRead());
  }

  Future<StorageObject> create({
    required StorageArea storageArea,
    required String originalName,
    required String? mimeType,
    required Stream<List<int>> content,
  }) async {
    final storageKey = _generateStorageKey(
      originalName: originalName,
      storageArea: storageArea,
    );

    final file = _fileFor(storageKey: storageKey);
    await file.parent.create(recursive: true);

    final storedFileInfo = await _writeFile(file, content: content);

    try {
      return await _storageObjectRepository.create(
        .new(
          storageKey: storageKey,
          originalName: originalName,
          mimeType: mimeType,
          sizeBytes: storedFileInfo.sizeBytes,
          checksumSha256: storedFileInfo.checksum,
        ),
      );
    } on Exception {
      await _ignoreExceptions(file.delete);
      rethrow;
    }
  }

  /// Updates a stored file and its [StorageObject] metadata.
  ///
  /// Returns `null` if the storage object does not exist.
  Future<StorageObject?> update(
    String id, {
    required StorageArea storageArea,
    required String originalName,
    required String? mimeType,
    required Stream<List<int>> content,
  }) async {
    final storageObject = await _storageObjectRepository.findById(id);
    if (storageObject == null) {
      return null;
    }

    final oldStorageKey = storageObject.storageKey;
    final newStorageKey = _generateStorageKey(
      originalName: originalName,
      storageArea: storageArea,
    );

    final newFile = _fileFor(storageKey: newStorageKey);
    await newFile.parent.create(recursive: true);

    final storedFileInfo = await _writeFile(newFile, content: content);

    try {
      final updatedStorageObject = await _storageObjectRepository.update(
        id,
        .new(
          storageKey: .value(newStorageKey),
          originalName: .value(originalName),
          mimeType: .value(mimeType),
          sizeBytes: .value(storedFileInfo.sizeBytes),
          checksumSha256: .value(storedFileInfo.checksum),
        ),
      );

      if (updatedStorageObject == null) {
        await _ignoreExceptions(newFile.delete);
        return null;
      }

      final oldFile = _fileFor(storageKey: oldStorageKey);
      await _ignoreExceptions(oldFile.delete);

      return updatedStorageObject;
    } on Exception {
      await _ignoreExceptions(newFile.delete);
      rethrow;
    }
  }

  /// Deletes the stored file and its [StorageObject] metadata.
  ///
  /// Returns `false` if the storage object does not exist.
  Future<bool> delete(String id) async {
    final storageObject = await _storageObjectRepository.findById(id);
    if (storageObject == null) {
      return false;
    }

    final file = _fileFor(storageKey: storageObject.storageKey);

    if (!file.existsSync()) {
      return await _storageObjectRepository.delete(id);
    }

    final deletingFile = _deletingFileFor(id);

    await deletingFile.parent.create(recursive: true);
    await file.rename(deletingFile.path);

    try {
      final deleted = await _storageObjectRepository.delete(id);

      if (!deleted) {
        await deletingFile.rename(file.path);
        return false;
      }

      await deletingFile.delete();
      return true;
    } on Exception {
      await _ignoreExceptions(() => deletingFile.rename(file.path));
      rethrow;
    }
  }

  String _generateStorageKey({
    required String originalName,
    required StorageArea storageArea,
  }) {
    final uuid = const Uuid().v7();
    final fileExtension = p.extension(originalName);
    return p.join(
      storageArea.directoryName,
      fileExtension.isEmpty ? uuid : '$uuid.$fileExtension',
    );
  }

  File _fileFor({required String storageKey}) =>
      _fileSystem.file(p.join(_storageDirectory.path, storageKey));

  File _deletingFileFor(String id) =>
      _fileSystem.file(p.join(_storageDirectory.path, '.deleting', '$id.tmp'));

  /// Writes [content] to [file], calculating its size and SHA-256 checksum while
  /// writing, and returns the resulting metadata.
  Future<_StoredFileInfo> _writeFile(
    File file, {
    required Stream<List<int>> content,
  }) async {
    var sizeBytes = 0;
    final sink = file.openWrite();

    final digestSink = AccumulatorSink<Digest>();
    final digestInput = sha256.startChunkedConversion(digestSink);

    try {
      await for (final chunk in content) {
        sizeBytes += chunk.length;
        sink.add(chunk);
        digestInput.add(chunk);
      }

      digestInput.close();

      await sink.flush();
      await sink.close();

      final checksum = digestSink.events.single.toString();

      digestSink.clear();
      digestSink.close();

      return .new(sizeBytes, checksum);
    } on Exception {
      digestInput.close();

      digestSink.clear();
      digestSink.close();

      await _ignoreExceptions(sink.close);
      await _ignoreExceptions(file.delete);

      rethrow;
    }
  }

  Future<void> _ignoreExceptions(FutureOr<void> Function() action) async {
    try {
      await action();
    } on Exception {
      // No-op
    }
  }
}

@immutable
class const _StoredFileInfo(final int sizeBytes, final String checksum);
