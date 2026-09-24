import 'package:librelab_api_contract/librelab_api_contract.dart' as dto;
import 'package:librelab_server/file_storage/storage_object/storage_object.dart';

extension StorageObjectMapper on StorageObject {
  dto.StorageObject toResponse() => .new(
    id: id,
    storageKey: storageKey,
    originalName: originalName,
    mimeType: mimeType,
    sizeBytes: sizeBytes,
    checksumSha256: checksumSha256,
    purpose: purpose.toResponse(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension StorageObjectPurposeMapper on StorageObjectPurpose {
  dto.StorageObjectPurpose toResponse() => switch (this) {
    .labImage => .labImage,
  };
}

extension StorageObjectPurposeDtoMapper on dto.StorageObjectPurpose {
  StorageObjectPurpose toDomain() => switch (this) {
    .labImage => .labImage,
    .unknown => throw StateError('Unexpected storage object purpose: $name.'),
  };
}
