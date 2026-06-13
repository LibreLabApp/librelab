import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'logout_request.g.dart';

@immutable
@JsonSerializable()
class LogoutRequest {
  const LogoutRequest({required this.refreshToken});

  factory LogoutRequest.fromJson(JsonMap json) => _$LogoutRequestFromJson(json);

  JsonMap toJson() => _$LogoutRequestToJson(this);

  final String refreshToken;
}
