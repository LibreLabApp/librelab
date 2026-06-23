import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'login_request.g.dart';

@immutable
@JsonSerializable()
class const LoginRequest({
  required final String email,
  required final String password,
  required final String? deviceId,
}) {
  factory fromJson(JsonMap json) => _$LoginRequestFromJson(json);
  JsonMap toJson() => _$LoginRequestToJson(this);
}
