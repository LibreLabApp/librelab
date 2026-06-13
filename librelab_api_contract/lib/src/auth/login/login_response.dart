import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:librelab_api_contract/src/auth/auth_token.dart';
import 'package:librelab_api_contract/src/user/user.dart';
import 'package:meta/meta.dart';

part 'login_response.g.dart';

@immutable
@JsonSerializable()
class LoginResponse {
  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(JsonMap json) => _$LoginResponseFromJson(json);

  final AuthToken accessToken;
  final AuthToken refreshToken;
  final User user;

  JsonMap toJson() => _$LoginResponseToJson(this);
}
