import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'update_lab_settings_request.g.dart';

@immutable
@JsonSerializable()
class const UpdateLabSettingsRequest({
  required final String? labName,
  required final bool? loginDisabled,

  /// The image ID to set or replace.
  ///
  /// A non-null value sets or replaces the current image. A null value keeps
  /// the current image unchanged.
  ///
  /// To remove the current image, delete the storage object.
  required final String? labImageId,
}) {
  factory fromJson(JsonMap json) => _$UpdateLabSettingsRequestFromJson(json);
  JsonMap toJson() => _$UpdateLabSettingsRequestToJson(this);
}
