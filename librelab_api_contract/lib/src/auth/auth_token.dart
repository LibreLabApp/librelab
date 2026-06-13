import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'auth_token.g.dart';

@immutable
@JsonSerializable()
class AuthToken {
  const AuthToken({required this.token, required this.expiresAt});

  factory AuthToken.fromJson(JsonMap json) => _$AuthTokenFromJson(json);

  final String token;
  final DateTime expiresAt;

  JsonMap toJson() => _$AuthTokenToJson(this);
}
