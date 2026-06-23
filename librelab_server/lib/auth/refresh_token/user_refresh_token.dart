import 'package:meta/meta.dart';

@immutable
class const UserRefreshToken({
  required final int id,
  required final String userId,
  required final String tokenHash,
  required final UserRefreshTokenClientMetadata clientMetadata,
  required final DateTime createdAt,
  required final DateTime expiresAt,
}) {
  @override
  String toString() =>
      'UserRefreshToken(id: $id, userId: $userId, tokenHash: **** (CENSORED), clientMetadata: $clientMetadata, createdAt: $createdAt, expires_at: $expiresAt)';
}

@immutable
class const UserRefreshTokenClientMetadata({
  required final String? deviceId,
  required final String? ipAddress,
  required final String? userAgent,
}) {
  factory empty() =>
      const .new(deviceId: null, ipAddress: null, userAgent: null);

  @override
  String toString() =>
      'UserRefreshTokenClientMetadata(deviceId: $deviceId, ipAddress: $ipAddress, userAgent: $userAgent)';
}

@immutable
class const UserRefreshTokenCreate({
  required final String userId,
  required final String tokenHash,
  required final UserRefreshTokenClientMetadata clientMetadata,
  required final DateTime expiresAt,
});
