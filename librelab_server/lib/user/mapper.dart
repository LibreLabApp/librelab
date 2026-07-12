import 'package:librelab_api_contract/librelab_api_contract.dart' as dto;
import 'package:librelab_server/auth/auth_service/auth_service.dart';
import 'package:librelab_server/user/role/mapper.dart';
import 'package:librelab_server/user/user.dart';

extension AuthTokenMapper on AuthToken {
  dto.AuthToken toResponse() => .new(value: token, expiresAt: expiresAt);
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
