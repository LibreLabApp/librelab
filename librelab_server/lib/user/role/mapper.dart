import 'package:librelab_api_contract/librelab_api_contract.dart' as dto;
import 'package:librelab_server/user/role/role.dart';

extension PermissionMapper on Permission {
  dto.Permission toResponse() => switch (this) {
    .backupCreate => .backupCreate,
    .backupRestore => .backupRestore,
    .labSettingsUpdate => .labSettingsUpdate,
  };
}

extension RoleMapper on Role {
  dto.Role toResponse() => .new(
    id: id,
    name: name,
    permissions: .unmodifiable(permissions.map((e) => e.toResponse()).toList()),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
