import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'role.g.dart';

enum Permission { backupCreate, backupRestore, unknown }

extension PermissionJson on Permission {
  // Uses an extension method to consume the generated code
  // instead of adding toJson() directly to the generated code,
  // which conflicts with json_serializable behavior
  String toJson() => _$PermissionEnumMap[this]!;
}

@immutable
@JsonSerializable()
class Role {
  Role({
    required this.id,
    required this.name,
    required List<Permission> permissions,
    required this.createdAt,
    required this.updatedAt,
  }) : permissions = List.unmodifiable(permissions);

  factory Role.fromJson(JsonMap json) => _$RoleFromJson(json);

  JsonMap toJson() => _$RoleToJson(this);

  final int id;
  final String name;

  @JsonKey(
    // Adding a new enum not considered a breaking change.
    unknownEnumValue: Permission.unknown,
  )
  final List<Permission> permissions;
  final DateTime createdAt;
  final DateTime updatedAt;
}
