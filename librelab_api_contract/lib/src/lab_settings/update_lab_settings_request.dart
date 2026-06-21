import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'update_lab_settings_request.g.dart';

@immutable
@JsonSerializable()
class UpdateLabSettingsRequest {
  const UpdateLabSettingsRequest({
    required this.labName,
    required this.loginDisabled,
  });

  factory UpdateLabSettingsRequest.fromJson(JsonMap json) =>
      _$UpdateLabSettingsRequestFromJson(json);

  final String? labName;
  final bool? loginDisabled;

  JsonMap toJson() => _$UpdateLabSettingsRequestToJson(this);
}
