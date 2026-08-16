import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_flutter/common/json_types.dart';
import 'package:librelab_flutter/user/models/role.dart';
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
