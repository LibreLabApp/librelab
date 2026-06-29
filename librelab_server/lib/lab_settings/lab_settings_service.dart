import 'package:librelab_server/audit_log/audit_log.dart';
import 'package:librelab_server/audit_log/audit_log_repository.dart';
import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/lab_settings/lab_settings.dart';
import 'package:librelab_server/lab_settings/lab_settings_repository.dart';

final class LabSettingsService({
  required final SqlDatabaseAccess _db,
  required final LabSettingsRepository _labSettingsRepository,
  required final AuditLogRepository _auditLogRepository,
}) {
  Future<LabSettings> update(
    LabSettingsPatch patch, {
    required String userId,
    required RequestMetadata requestMetadata,
  }) => _db.transaction((tx) async {
    final old = cached;
    final updated = await _labSettingsRepository.update(patch, executor: tx);

    await _auditLogRepository.create(
      .new(
        userId: userId,
        action: .update,
        entityType: .labSettings,
        entityId: updated.id.toString(),
        oldValue: old.toAuditJson(),
        newValue: updated.toAuditJson(),
        requestMetadata: requestMetadata,
      ),
      executor: tx,
    );

    return updated;
  });

  LabSettings get cached => _labSettingsRepository.cached;
}
