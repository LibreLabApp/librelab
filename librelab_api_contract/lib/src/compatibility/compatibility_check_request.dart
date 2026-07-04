import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'compatibility_check_request.g.dart';

@immutable
@JsonSerializable()
class const CompatibilityCheckRequest({
  required final int clientApiContractVersion,
}) {
  factory fromJson(JsonMap json) => _$CompatibilityCheckRequestFromJson(json);
  JsonMap toJson() => _$CompatibilityCheckRequestToJson(this);
}
