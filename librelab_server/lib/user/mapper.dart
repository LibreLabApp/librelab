import 'package:librelab_api_contract/librelab_api_contract.dart' as dto;
import 'package:librelab_server/auth/auth_service.dart';
import 'package:librelab_server/user/role/role.dart';
import 'package:librelab_server/user/user.dart';

extension PermissionMapper on Permission {
  dto.Permission toResponse() => switch (this) {
    .backupCreate => .backupCreate,
    .backupRestore => .backupRestore,
    .labSettingsUpdate => .labSettingsUpdate,
  };
}

extension AuthTokenMapper on AuthToken {
  dto.AuthToken toResponse() => .new(token: token, expiresAt: expiresAt);
}

extension UserMapper on User {
  dto.User toResponse() => .new(
    id: id,
    email: email,
    fullName: fullName,
    phoneNumber: phoneNumber,
    isSuperUser: isSuperUser,
    role: role?.toResponse(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension RoleMapper on Role {
  dto.Role toResponse() => .new(
    id: id,
    name: name,
    permissions: permissions.map((e) => e.toResponse()).toList(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
