import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:librelab_api_contract/src/user/role/role.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

@immutable
@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.email,
    required this.tokenVersion,
    required this.fullName,
    required this.phoneNumber,
    required this.isSuperUser,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(JsonMap json) => _$UserFromJson(json);

  JsonMap toJson() => _$UserToJson(this);

  final String id;
  final String email;
  final int tokenVersion;
  final String fullName;
  final String? phoneNumber;
  final bool isSuperUser;
  final Role? role;
  final DateTime createdAt;
  final DateTime updatedAt;
}
