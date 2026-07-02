import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'auth_token.g.dart';

@immutable
@JsonSerializable()
class const AuthToken({
  required final String token,
  required final DateTime expiresAt,
}) {
  factory fromJson(JsonMap json) => _$AuthTokenFromJson(json);
  JsonMap toJson() => _$AuthTokenToJson(this);
}
