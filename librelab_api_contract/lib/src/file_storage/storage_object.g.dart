// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageObject _$StorageObjectFromJson(Map<String, dynamic> json) =>
    StorageObject(
      id: json['id'] as String,
      storageKey: json['storageKey'] as String,
      originalName: json['originalName'] as String,
      mimeType: json['mimeType'] as String?,
      sizeBytes: (json['sizeBytes'] as num).toInt(),
      checksumSha256: json['checksumSha256'] as String,
      purpose: $enumDecode(
        _$StorageObjectPurposeEnumMap,
        json['purpose'],
        unknownValue: StorageObjectPurpose.unknown,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$StorageObjectToJson(StorageObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storageKey': instance.storageKey,
      'originalName': instance.originalName,
      'mimeType': instance.mimeType,
      'sizeBytes': instance.sizeBytes,
      'checksumSha256': instance.checksumSha256,
      'purpose': instance.purpose,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$StorageObjectPurposeEnumMap = {
  StorageObjectPurpose.labImage: 'labImage',
  StorageObjectPurpose.unknown: 'unknown',
};
