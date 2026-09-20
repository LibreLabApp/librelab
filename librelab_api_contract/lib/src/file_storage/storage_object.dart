import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'storage_object.g.dart';

@immutable
@JsonSerializable()
class const StorageObject({
  required final String id,
  required final String storageKey,
  required final String originalName,
  required final String? mimeType,
  required final int sizeBytes,
  required final String checksumSha256,
  @JsonKey(
    // Adding a new enum is not considered a breaking change.
    unknownEnumValue: StorageObjectPurpose.unknown,
  )
  required final StorageObjectPurpose purpose,
  required final DateTime createdAt,
  required final DateTime updatedAt,
}) {
  factory fromJson(JsonMap json) => _$StorageObjectFromJson(json);
  JsonMap toJson() => _$StorageObjectToJson(this);
}

enum StorageObjectPurpose {
  labImage,
  unknown;

  static StorageObjectPurpose? fromJson(String value) =>
      _$StorageObjectPurposeEnumMap.entries
          .firstWhereOrNull((entry) => entry.value == value)
          ?.key;

  String toJson() => _$StorageObjectPurposeEnumMap[this]!;

  /// The multipart form-data field name used to specify the storage object purpose.
  static const String formDataName = 'purpose';
}
