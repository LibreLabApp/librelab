import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'logout_request.g.dart';

@immutable
@JsonSerializable()
class const LogoutRequest({required final String refreshToken}) {
  factory fromJson(JsonMap json) => _$LogoutRequestFromJson(json);
  JsonMap toJson() => _$LogoutRequestToJson(this);
}
