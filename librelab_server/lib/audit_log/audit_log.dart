import 'package:meta/meta.dart';

enum AuditAction { labSettingsUpdate }

@immutable
class AuditLog {
  const AuditLog({
    required this.id,
    required this.userId,
    required this.action,
    required this.entityId,
    required this.oldValue,
    required this.newValue,
    required this.ipAddress,
    required this.userAgent,
    required this.createdAt,
  });

  final int id;
  final String userId;
  final AuditAction action;
  final String entityId;
  final String oldValue;
  final String newValue;
  final String? ipAddress;
  final String? userAgent;
  final DateTime createdAt;
}

@immutable
class AuditLogCreate {
  const AuditLogCreate({
    required this.userId,
    required this.action,
    required this.entityId,
    required this.oldValue,
    required this.newValue,
    required this.ipAddress,
    required this.userAgent,
  });

  final String userId;
  final AuditAction action;
  final String entityId;
  final String oldValue;
  final String newValue;
  final String ipAddress;
  final String userAgent;
}
