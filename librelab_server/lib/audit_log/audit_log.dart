import 'package:meta/meta.dart';

enum AuditAction { labSettingsUpdate }

@immutable
class const AuditLog({
  required final int id,
  required final String userId,
  required final AuditAction action,
  required final String entityId,
  required final String oldValue,
  required final String newValue,
  required final String? ipAddress,
  required final String? userAgent,
  required final DateTime createdAt,
});

@immutable
class const AuditLogCreate({
  required final String userId,
  required final AuditAction action,
  required final String entityId,
  required final String oldValue,
  required final String newValue,
  required final String ipAddress,
  required final String userAgent,
});
