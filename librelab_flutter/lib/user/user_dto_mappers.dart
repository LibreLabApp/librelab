import 'package:librelab_api_contract/librelab_api_contract.dart' as api;
import 'package:librelab_flutter/auth/login_identity/models/login_identity.dart';
import 'package:librelab_flutter/user/models/role.dart';
import 'package:librelab_flutter/user/models/user.dart';

extension UserDtoMapping on api.User {
  User toDomain() => .new(
    id: id,
    email: email,
    fullName: fullName,
    phoneNumber: phoneNumber,
    isSuperUser: isSuperUser,
    role: switch (role) {
      final role? => role.toDomain(),
      null => null,
    },
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension AuthTokenDtoMapping on api.AuthToken {
  AuthToken toDomain() => .new(value: value, expiresAt: expiresAt);
}

extension RoleDtoMapping on api.Role {
  Role toDomain() => .new(
    id: id,
    name: name,
    permissions: permissions.map((e) => e.toDomain()).toList(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension PermissionDtoMapping on api.Permission {
  Permission toDomain() => switch (this) {
    .backupCreate => .backupCreate,
    .backupRestore => .backupRestore,
    .labSettingsUpdate => .labSettingsUpdate,
    .unknown => .unknown,
  };
}
