import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:librelab_api_contract/src/user/role/role.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

@immutable
@JsonSerializable()
class const User({
  required final String id,
  required final String email,
  required final String fullName,
  required final String? phoneNumber,
  required final bool isSuperUser,
  required final Role? role,
  required final DateTime createdAt,
  required final DateTime updatedAt,
}) {
  factory fromJson(JsonMap json) => _$UserFromJson(json);
  JsonMap toJson() => _$UserToJson(this);
}
