import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'login_status_response.g.dart';

@immutable
@JsonSerializable()
class const LoginStatusResponse({required final bool isLoginDisabled}) {
  factory fromJson(JsonMap json) => _$LoginStatusResponseFromJson(json);
  JsonMap toJson() => _$LoginStatusResponseToJson(this);
}
