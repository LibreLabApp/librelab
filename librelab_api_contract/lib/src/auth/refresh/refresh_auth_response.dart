import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/auth/auth_token.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'refresh_auth_response.g.dart';

@immutable
@JsonSerializable()
class const RefreshAuthResponse({
  required final AuthToken accessToken,
  required final AuthToken refreshToken,
}) {
  factory fromJson(JsonMap json) => _$RefreshAuthResponseFromJson(json);
  JsonMap toJson() => _$RefreshAuthResponseToJson(this);
}
