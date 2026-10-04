import 'package:librelab_server/audit_log/audit_log.dart';
import 'package:librelab_server/audit_log/audit_log_repository.dart';
import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/file_storage/exceptions.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object.dart';
import 'package:librelab_server/file_storage/storage_object/storage_object_repository.dart';
import 'package:librelab_server/lab_settings/lab_settings.dart';
import 'package:librelab_server/lab_settings/lab_settings_repository.dart';
import 'package:librelab_server/utils/validation/id_validation.dart';

final class LabSettingsService({
  required final SqlDatabaseAccess _db,
  required final LabSettingsRepository _labSettingsRepository,
  required final AuditLogRepository _auditLogRepository,
  required final StorageObjectRepository _storageObjectRepository,
}) {
  static const AuditEntityType _auditEntityType = .labSettings;
  static const StorageObjectPurpose _expectedStorageObjectPurpose = .labImage;

  Future<LabSettings> update(
    LabSettingsPatch patch, {
    required String userId,
    required RequestMetadata requestMetadata,
  }) async {
    if (patch.labImageId.value case final labImageId?) {
      // TODO: Should we keep that kind of logic at the service class or move it to
      //  the route/controller class? Apply the change everywhere else where validateId() is called
      validateId(labImageId);

      final purpose = await _storageObjectRepository.findPurposeById(
        labImageId,
      );

      if (purpose == null) {
        throw StorageObjectNotFoundException(labImageId);
      }

      if (purpose != _expectedStorageObjectPurpose) {
        throw InvalidStorageObjectPurposeException(
          id: labImageId,
          expected: _expectedStorageObjectPurpose,
          actual: purpose,
        );
      }
    }

    return _db.transaction((tx) async {
      final old = cached;

      final updated = await _labSettingsRepository.update(patch, executor: tx);

      await _auditLogRepository.create(
        .new(
          userId: userId,
          action: .update,
          entityType: _auditEntityType,
          entityId: updated.id.toString(),
          oldValue: old.toAuditJson(),
          newValue: updated.toAuditJson(),
          requestMetadata: requestMetadata,
        ),
        executor: tx,
      );

      return updated;
    });
  }

  LabSettings get cached => _labSettingsRepository.cached;
}
