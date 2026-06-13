import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:librelab_api_contract/src/auth/auth_token.dart';
import 'package:meta/meta.dart';

part 'token_refresh_response.g.dart';

@immutable
@JsonSerializable()
class TokenRefreshResponse {
  const TokenRefreshResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenRefreshResponse.fromJson(JsonMap json) =>
      _$TokenRefreshResponseFromJson(json);

  JsonMap toJson() => _$TokenRefreshResponseToJson(this);

  final AuthToken accessToken;
  final AuthToken refreshToken;
}
