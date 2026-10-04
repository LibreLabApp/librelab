import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'lab_settings.g.dart';

@immutable
@JsonSerializable()
class const LabSettings({
  required final String? labName,
  required final bool loginDisabled,
  required final String? labImageId,
  required final DateTime updatedAt,
}) {
  factory fromJson(JsonMap json) => _$LabSettingsFromJson(json);
  JsonMap toJson() => _$LabSettingsToJson(this);
}
