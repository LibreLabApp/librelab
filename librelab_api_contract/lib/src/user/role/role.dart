import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'role.g.dart';

enum Permission { backupCreate, backupRestore, labSettingsUpdate, unknown }

extension PermissionJson on Permission {
  // Uses an extension method to consume the generated code
  // instead of adding toJson() directly to the generated code,
  // which conflicts with json_serializable behavior
  String toJson() => _$PermissionEnumMap[this]!;
}

@immutable
@JsonSerializable()
class const Role({
  required final int id,
  required final String name,
  @JsonKey(
    // Adding a new enum not considered a breaking change.
    unknownEnumValue: Permission.unknown,
  )
  required final List<Permission> permissions,
  required final DateTime createdAt,
  required final DateTime updatedAt,
}) {
  factory fromJson(JsonMap json) => _$RoleFromJson(json);
  JsonMap toJson() => _$RoleToJson(this);
}
