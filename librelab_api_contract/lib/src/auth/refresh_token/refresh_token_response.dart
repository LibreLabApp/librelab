import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:librelab_api_contract/src/auth/auth_token.dart';
import 'package:meta/meta.dart';

part 'refresh_token_response.g.dart';

@immutable
@JsonSerializable()
class RefreshTokenResponse {
  const RefreshTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshTokenResponse.fromJson(JsonMap json) =>
      _$RefreshTokenResponseFromJson(json);

  JsonMap toJson() => _$RefreshTokenResponseToJson(this);

  final AuthToken accessToken;
  final AuthToken refreshToken;
}
