import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'logout_response.g.dart';

@immutable
@JsonSerializable()
class LogoutResponse {
  const LogoutResponse({required this.tokenRevoked});

  factory LogoutResponse.fromJson(JsonMap json) =>
      _$LogoutResponseFromJson(json);

  JsonMap toJson() => _$LogoutResponseToJson(this);

  final bool tokenRevoked;
}
