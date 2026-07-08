import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'refresh_auth_request.g.dart';

@immutable
@JsonSerializable()
class const RefreshAuthRequest({required final String refreshToken}) {
  factory fromJson(JsonMap json) => _$RefreshAuthRequestFromJson(json);
  JsonMap toJson() => _$RefreshAuthRequestToJson(this);
}
