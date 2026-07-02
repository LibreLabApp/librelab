import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/auth/auth_token.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:librelab_api_contract/src/user/user.dart';
import 'package:meta/meta.dart';

part 'login_response.g.dart';

@immutable
@JsonSerializable()
class const LoginResponse({
  required final AuthToken accessToken,
  required final AuthToken refreshToken,
  required final User user,
}) {
  factory fromJson(JsonMap json) => _$LoginResponseFromJson(json);
  JsonMap toJson() => _$LoginResponseToJson(this);
}
