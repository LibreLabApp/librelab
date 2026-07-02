import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'lab_settings_response.g.dart';

@immutable
@JsonSerializable()
class const LabSettingsResponse({
  required final String? labName,
  required final bool loginDisabled,
}) {
  factory fromJson(JsonMap json) => _$LabSettingsResponseFromJson(json);
  JsonMap toJson() => _$LabSettingsResponseToJson(this);
}
