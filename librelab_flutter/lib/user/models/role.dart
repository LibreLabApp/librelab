import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_flutter/common/json_types.dart';
import 'package:meta/meta.dart';

part 'role.g.dart';

enum Permission {
  backupCreate,
  backupRestore,
  labSettingsUpdate,

  /// The server sent a permission that this client does not recognize.
  unknown,
}

@immutable
@JsonSerializable()
class const Role({
  required final int id,
  required final String name,
  @JsonKey(
    // Adding a new enum is not considered a breaking change.
    unknownEnumValue: Permission.unknown,
  )
  required final List<Permission> permissions,
  required final DateTime createdAt,
  required final DateTime updatedAt,
}) {
  factory fromJson(JsonMap json) => _$RoleFromJson(json);
  JsonMap toJson() => _$RoleToJson(this);
}
