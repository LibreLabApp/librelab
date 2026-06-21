import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'lab_settings_response.g.dart';

@immutable
@JsonSerializable()
class LabSettingsResponse {
  const LabSettingsResponse({
    required this.labName,
    required this.loginDisabled,
  });

  factory LabSettingsResponse.fromJson(JsonMap json) =>
      _$LabSettingsResponseFromJson(json);

  final String? labName;
  final bool loginDisabled;

  JsonMap toJson() => _$LabSettingsResponseToJson(this);
}
