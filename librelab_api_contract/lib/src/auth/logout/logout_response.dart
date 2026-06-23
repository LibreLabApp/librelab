import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'logout_response.g.dart';

@immutable
@JsonSerializable()
class const LogoutResponse({required final bool tokenRevoked}) {
  factory fromJson(JsonMap json) => _$LogoutResponseFromJson(json);
  JsonMap toJson() => _$LogoutResponseToJson(this);
}
