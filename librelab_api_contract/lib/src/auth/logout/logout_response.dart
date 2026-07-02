import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'logout_response.g.dart';

@immutable
@JsonSerializable()
class const LogoutResponse({required final bool tokenRevoked}) {
  factory fromJson(JsonMap json) => _$LogoutResponseFromJson(json);
  JsonMap toJson() => _$LogoutResponseToJson(this);
}
