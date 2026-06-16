import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'refresh_token_request.g.dart';

@immutable
@JsonSerializable()
class RefreshTokenRequest {
  const RefreshTokenRequest({required this.refreshToken});

  factory RefreshTokenRequest.fromJson(JsonMap json) =>
      _$RefreshTokenRequestFromJson(json);

  JsonMap toJson() => _$RefreshTokenRequestToJson(this);

  final String refreshToken;
}
