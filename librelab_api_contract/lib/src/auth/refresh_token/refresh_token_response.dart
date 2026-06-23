import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:librelab_api_contract/src/auth/auth_token.dart';
import 'package:meta/meta.dart';

part 'refresh_token_response.g.dart';

@immutable
@JsonSerializable()
class const RefreshTokenResponse({
  required final AuthToken accessToken,
  required final AuthToken refreshToken,
}) {
  factory fromJson(JsonMap json) => _$RefreshTokenResponseFromJson(json);
  JsonMap toJson() => _$RefreshTokenResponseToJson(this);
}
