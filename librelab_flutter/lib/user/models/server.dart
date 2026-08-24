import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_flutter/common/json_types.dart' show JsonMap;
import 'package:meta/meta.dart';

part 'server.g.dart';

@immutable
@JsonSerializable()
class const Server({
  required final int id,

  /// The base URL of the server's API.
  /// On the web, this can be a relative URL reference such as `/api`.
  required final Uri apiBaseUrl,

  /// The local display name for this server configuration.
  /// Does not necessarily match the canonical lab name reported by the server.
  required final String name,
  // TODO: Add lab settings here?
}) {
  factory fromJson(JsonMap json) => _$ServerFromJson(json);
  JsonMap toJson() => _$ServerToJson(this);
}
