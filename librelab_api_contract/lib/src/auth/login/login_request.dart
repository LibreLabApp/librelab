import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'login_request.g.dart';

@immutable
@JsonSerializable()
class LoginRequest {
  const LoginRequest({
    required this.email,
    required this.password,
    required this.deviceId,
  });

  factory LoginRequest.fromJson(JsonMap json) => _$LoginRequestFromJson(json);

  JsonMap toJson() => _$LoginRequestToJson(this);

  final String email;
  final String password;
  final String? deviceId;
}
