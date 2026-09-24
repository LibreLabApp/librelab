import 'dart:async';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:file/file.dart';
import 'package:librelab_server/audit_log/audit_log.dart';
import 'package:librelab_server/audit_log/audit_log_repository.dart';
import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object_repository.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class FileStorageService({
  required final SqlDatabaseAccess _db,
  required final StorageObjectRepository _storageObjectRepository,
  required final FileSystem _fs,
  required String storageDirectoryPath,
  required final AuditLogRepository _auditLogRepository,
}) {
  final Directory _storageDirectory = _fs.directory(storageDirectoryPath);

  // Maximum allowed file size.
  static const int _maxFileSizeBytes = 10 * 1024 * 1024; // 10 MiB

  static const AuditEntityType _auditEntityType = .storageObject;

  /// See [StorageObjectRepository.findById]
  Future<StorageObject?> findById(String id) =>
      _storageObjectRepository.findById(id);

  /// See [StorageObjectRepository.findPurposeById]
  Future<StorageObjectPurpose?> findPurposeById(String id) =>
      _storageObjectRepository.findPurposeById(id);

  /// Opens a stored file for reading.
  ///
  /// Returns `null` if the file does not exist.
  StoredFile? open(StorageObject storageObject) {
    final file = _fileFor(storageKey: storageObject.storageKey);

    if (!file.existsSync()) {
      return null;
    }

    return .new(content: file.openRead());
  }

  Future<StorageObject> create({
    required String originalName,
    required String mimeType,
    required Stream<List<int>> content,
    required StorageObjectPurpose purpose,
    required bool isUpload,
    required String userId,
    required RequestMetadata requestMetadata,
  }) async {
    final storageKey = _generateStorageKey(originalName: originalName);

    final file = _fileFor(storageKey: storageKey);
    await file.parent.create(recursive: true);

    final storedFileInfo = await _writeFile(file, content: content);

    try {
      return await _db.transaction((tx) async {
        final updated = await _storageObjectRepository.create(
          .new(
            storageKey: storageKey,
            originalName: originalName,
            mimeType: mimeType,
            sizeBytes: storedFileInfo.sizeBytes,
            checksumSha256: storedFileInfo.checksum,
            purpose: purpose,
            isUpload: isUpload,
          ),
          executor: tx,
        );
        await _auditLogRepository.create(
          .new(
            userId: userId,
            action: .create,
            entityType: _auditEntityType,
            entityId: updated.id,
            oldValue: {},
            newValue: updated.toAuditJson(),
            requestMetadata: requestMetadata,
          ),
          executor: tx,
        );
        return updated;
      });
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
    required String originalName,
    required String mimeType,
    required Stream<List<int>> content,
    required String userId,
    required RequestMetadata requestMetadata,
  }) async {
    final oldStorageObject = await _storageObjectRepository.findById(id);
    if (oldStorageObject == null) {
      return null;
    }

    final newStorageKey = _generateStorageKey(originalName: originalName);
    final newFile = _fileFor(storageKey: newStorageKey);

    await newFile.parent.create(recursive: true);
    final storedFileInfo = await _writeFile(newFile, content: content);

    try {
      final updatedStorageObject = await _db.transaction((tx) async {
        final updated = await _storageObjectRepository.update(
          id,
          .new(
            storageKey: .value(newStorageKey),
            originalName: .value(originalName),
            mimeType: .value(mimeType),
            sizeBytes: .value(storedFileInfo.sizeBytes),
            checksumSha256: .value(storedFileInfo.checksum),
          ),
          executor: tx,
        );

        if (updated == null) {
          return null;
        }

        await _auditLogRepository.create(
          .new(
            userId: userId,
            action: .update,
            entityType: _auditEntityType,
            entityId: updated.id,
            oldValue: oldStorageObject.toAuditJson(),
            newValue: updated.toAuditJson(),
            requestMetadata: requestMetadata,
          ),
          executor: tx,
        );

        final oldFile = _fileFor(storageKey: oldStorageObject.storageKey);

        // If file deletion fails, the database transaction is rolled back.
        await oldFile.delete();

        return updated;
      });

      if (updatedStorageObject == null) {
        await _ignoreExceptions(newFile.delete);
        return null;
      }

      return updatedStorageObject;
    } on Exception {
      await _ignoreExceptions(newFile.delete);
      rethrow;
    }
  }

  /// Deletes the stored file and its [StorageObject] metadata.
  ///
  /// Returns `false` if the storage object does not exist.
  Future<bool> delete(
    String id, {
    required String userId,
    required RequestMetadata requestMetadata,
  }) async {
    return _db.transaction((tx) async {
      final deleted = await _storageObjectRepository.delete(id, executor: tx);

      if (deleted == null) {
        return false;
      }

      await _auditLogRepository.create(
        .new(
          userId: userId,
          action: .delete,
          entityType: _auditEntityType,
          entityId: deleted.id,
          oldValue: deleted.toAuditJson(),
          newValue: {},
          requestMetadata: requestMetadata,
        ),
        executor: tx,
      );

      final file = _fileFor(storageKey: deleted.storageKey);

      // If file deletion fails, the database transaction is rolled back.
      await file.delete();

      return true;
    });
  }

  String _generateStorageKey({required String originalName}) {
    final uuid = const Uuid().v7();
    final fileExtension = p.extension(originalName);

    return fileExtension.isEmpty ? uuid : '$uuid$fileExtension';
  }

  File _fileFor({required String storageKey}) =>
      _fs.file(p.join(_storageDirectory.path, storageKey));

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

        if (sizeBytes > _maxFileSizeBytes) {
          throw FileStorageFileTooLargeException(
            fileSizeBytes: sizeBytes,
            maxSizeBytes: _maxFileSizeBytes,
          );
        }

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
class const StoredFile({required final Stream<List<int>> content});

@immutable
class const _StoredFileInfo(final int sizeBytes, final String checksum);

class FileStorageFileTooLargeException({
  required final int fileSizeBytes,
  required final int maxSizeBytes,
}) implements Exception {
  @override
  String toString() =>
      'The uploaded file size of $fileSizeBytes bytes exceeds the maximum allowed size of $maxSizeBytes bytes.';
}
