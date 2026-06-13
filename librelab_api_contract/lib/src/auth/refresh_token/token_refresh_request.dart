import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'token_refresh_request.g.dart';

@immutable
@JsonSerializable()
class TokenRefreshRequest {
  const TokenRefreshRequest({
    required this.refreshToken,
    required this.deviceId,
  });

  factory TokenRefreshRequest.fromJson(JsonMap json) =>
      _$TokenRefreshRequestFromJson(json);

  JsonMap toJson() => _$TokenRefreshRequestToJson(this);

  final String refreshToken;
  final String? deviceId;
}
