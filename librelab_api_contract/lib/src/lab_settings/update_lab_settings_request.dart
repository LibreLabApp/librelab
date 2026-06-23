import 'package:json_annotation/json_annotation.dart';
import 'package:json_utils/json_utils.dart';
import 'package:meta/meta.dart';

part 'update_lab_settings_request.g.dart';

@immutable
@JsonSerializable()
class const UpdateLabSettingsRequest({
  required final String? labName,
  required final bool? loginDisabled,
}) {
  factory fromJson(JsonMap json) => _$UpdateLabSettingsRequestFromJson(json);
  JsonMap toJson() => _$UpdateLabSettingsRequestToJson(this);
}
