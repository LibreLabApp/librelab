import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_flutter/common/json_types.dart';
import 'package:meta/meta.dart';

part 'auth_token_values.g.dart';

/// Authentication token values stored in secure storage.
///
/// Expiration timestamps are not considered sensitive data and are stored
/// separately.
@immutable
@JsonSerializable()
class const AuthTokenValues({
  required final String accessToken,
  required final String refreshToken,
}) {
  factory AuthTokenValues.fromJson(JsonMap json) =>
      _$AuthTokenValuesFromJson(json);
  JsonMap toJson() => _$AuthTokenValuesToJson(this);
}
