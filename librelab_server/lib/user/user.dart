import 'package:librelab_server/user/role/role.dart';
import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    required this.id,
    required this.email,
    required this.passwordHash,
    required this.tokenVersion,
    required this.fullName,
    required this.phoneNumber,
    required this.isSuperUser,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String email;
  final String passwordHash;
  final int tokenVersion;
  final String fullName;
  final String? phoneNumber;
  final bool isSuperUser;
  final Role? role;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  String toString() =>
      'User(id: $id, email: $email, passwordHash: **** (CENSORED), tokenVersion: $tokenVersion, fullName: $fullName, phoneNumber: $phoneNumber, isSuperUser: $isSuperUser, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
}
