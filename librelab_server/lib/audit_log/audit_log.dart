import 'package:json_utils/json_utils.dart' show JsonMap;
import 'package:meta/meta.dart';

enum AuditAction { create, update, delete }

enum AuditEntityType { labSettings }

@immutable
class const AuditLog({
  required final int id,
  required final String userId,
  required final AuditAction action,
  required final AuditEntityType entityType,
  required final String entityId,
  required final JsonMap oldValue,
  required final JsonMap newValue,
  required final RequestMetadata requestMetadata,
  required final DateTime createdAt,
});

@immutable
class const AuditLogCreate({
  required final String userId,
  required final AuditAction action,
  required final AuditEntityType entityType,
  required final String entityId,
  required final JsonMap oldValue,
  required final JsonMap newValue,
  required final RequestMetadata requestMetadata,
});

@immutable
class const RequestMetadata({
  required final String? ipAddress,
  required final String? userAgent,
});
