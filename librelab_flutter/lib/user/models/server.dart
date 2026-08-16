import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_flutter/common/json_types.dart' show JsonMap;
import 'package:meta/meta.dart';

part 'server.g.dart';

@immutable
@JsonSerializable()
class const Server({required final int id, required final Uri apiBaseUri}) {
  factory fromJson(JsonMap json) => _$ServerFromJson(json);
  JsonMap toJson() => _$ServerToJson(this);
}
