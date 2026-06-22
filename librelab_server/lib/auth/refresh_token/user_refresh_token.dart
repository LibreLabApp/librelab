import 'package:meta/meta.dart';

@immutable
class UserRefreshToken {
  const UserRefreshToken({
    required this.id,
    required this.userId,
    required this.tokenHash,
    required this.clientMetadata,
    required this.createdAt,
    required this.expiresAt,
  });

  final int id;
  final String userId;
  final String tokenHash;
  final UserRefreshTokenClientMetadata clientMetadata;
  final DateTime createdAt;
  final DateTime expiresAt;

  @override
  String toString() =>
      'UserRefreshToken(id: $id, userId: $userId, tokenHash: **** (CENSORED), clientMetadata: $clientMetadata, createdAt: $createdAt, expires_at: $expiresAt)';
}

@immutable
class UserRefreshTokenClientMetadata {
  const UserRefreshTokenClientMetadata({
    required this.deviceId,
    required this.ipAddress,
    required this.userAgent,
  });

  factory UserRefreshTokenClientMetadata.empty() =>
      const UserRefreshTokenClientMetadata(
        deviceId: null,
        ipAddress: null,
        userAgent: null,
      );

  final String? deviceId;
  final String? ipAddress;
  final String? userAgent;

  @override
  String toString() =>
      'UserRefreshTokenClientMetadata(deviceId: $deviceId, ipAddress: $ipAddress, userAgent: $userAgent)';
}

@immutable
class UserRefreshTokenCreate {
  const UserRefreshTokenCreate({
    required this.userId,
    required this.tokenHash,
    required this.clientMetadata,
    required this.expiresAt,
  });

  final String userId;
  final String tokenHash;
  final UserRefreshTokenClientMetadata clientMetadata;
  final DateTime expiresAt;
}
