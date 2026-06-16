import 'dart:convert' show utf8;

import 'package:clock/clock.dart' show clock;
import 'package:crypto/crypto.dart' show sha256;
import 'package:librelab_server/auth/authenticate_failures.dart';
import 'package:librelab_server/auth/refresh_token_failures.dart';
import 'package:librelab_server/auth/security/commonly_used_passwords.dart';
import 'package:librelab_server/auth/security/jwt/jwt_service.dart';
import 'package:librelab_server/auth/security/password_hasher/password_hasher.dart';
import 'package:librelab_server/auth/user_login_failures.dart';
import 'package:librelab_server/auth/user_register_failures.dart';
import 'package:librelab_server/user/refresh_token/user_refresh_token.dart';
import 'package:librelab_server/user/refresh_token/user_refresh_token_repository.dart';
import 'package:librelab_server/user/user.dart';
import 'package:librelab_server/user/user_repository.dart';
import 'package:librelab_server/utils/security/random_string.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:librelab_shared/result.dart';
import 'package:meta/meta.dart';

export 'package:librelab_server/auth/authenticate_failures.dart';
export 'package:librelab_server/auth/refresh_token_failures.dart';
export 'package:librelab_server/auth/user_login_failures.dart';
export 'package:librelab_server/auth/user_register_failures.dart';

@immutable
class AuthToken {
  const AuthToken({required this.token, required this.expiresAt});

  final String token;
  final DateTime expiresAt;
}

@immutable
class AuthTokens {
  const AuthTokens({required this.accessToken, required this.refreshTokenRaw});

  /// JWT access token
  final AuthToken accessToken;

  /// Opaque refresh token.
  /// Stored in the database as a hashed value.
  /// Sent to the client as raw/plain token.
  final AuthToken refreshTokenRaw;
}

typedef LoginResult = (User user, AuthTokens tokens);

class AuthService {
  AuthService({
    required this._passwordHasher,
    required this._userRepository,
    required this._jwtService,
    required this._userRefreshTokenRepository,
  });

  final PasswordHasher _passwordHasher;
  final UserRepository _userRepository;
  final JwtService _jwtService;
  final UserRefreshTokenRepository _userRefreshTokenRepository;

  static const Duration _accessTokenExpiryDuration = Duration(minutes: 10);
  static const Duration _refreshTokenExpiryDuration = Duration(days: 90);

  static bool _isPasswordLengthValid(String password) =>
      password.length >= 8 && password.length <= 255;

  static bool _isEmailFormatValid(String email) =>
      EmailValidator.validate(email);

  Future<Result<User, UserRegisterFailure>> registerUser({
    required String email,
    required String plainPassword,
    required String fullName,
    required String? phoneNumber,
    required UserType type,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedFullName = fullName.trim();
    final normalizedPhoneNumber = phoneNumber?.trim();

    if (!_isEmailFormatValid(normalizedEmail)) {
      return .failure(const InvalidEmailFormatFailure());
    }

    if (!_isPasswordLengthValid(plainPassword)) {
      return .failure(const InvalidPasswordLengthFailure());
    }

    if (isCommonPassword(plainPassword)) {
      return .failure(const CommonPasswordFailure());
    }

    if (normalizedFullName.isEmpty || normalizedFullName.length > 100) {
      return .failure(const InvalidFullNameLengthFailure());
    }

    if (normalizedPhoneNumber != null &&
        (normalizedPhoneNumber.isEmpty || normalizedPhoneNumber.length > 20)) {
      return .failure(const InvalidPhoneNumberLengthFailure());
    }

    if (await _userRepository.isEmailUsed(normalizedEmail)) {
      return .failure(const EmailInUseFailure());
    }

    final passwordHash = await _passwordHasher.hash(plainPassword);

    final user = await _userRepository.create(
      email: normalizedEmail,
      passwordHash: passwordHash,
      fullName: normalizedFullName,
      phoneNumber: normalizedPhoneNumber,
      type: type,
    );

    return .success(user);
  }

  Future<Result<LoginResult, UserLoginFailure>> loginUser({
    required String email,
    required String plainPassword,
    required UserRefreshTokenClientMetadata metadata,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (!_isEmailFormatValid(normalizedEmail) ||
        !_isPasswordLengthValid(plainPassword)) {
      return .failure(const InvalidLoginInputFailure());
    }

    final user = await _userRepository.findByEmail(normalizedEmail);

    if (user == null) {
      return .failure(const UserNotFoundFailure());
    }

    final isPasswordValid = await _passwordHasher.verify(
      plainPassword: plainPassword,
      passwordHash: user.passwordHash,
    );

    if (!isPasswordValid) {
      return .failure(const InvalidPasswordFailure());
    }

    return .success((
      user,
      await createAuthTokens(
        userId: user.id,
        tokenVersion: user.tokenVersion,
        metadata: metadata,
      ),
    ));
  }

  Future<AuthTokens> createAuthTokens({
    required String userId,
    required int tokenVersion,
    required UserRefreshTokenClientMetadata metadata,
  }) async {
    AuthToken issueJwtAccessToken() {
      const expiresIn = _accessTokenExpiryDuration;
      final expiresAt = _timeNowUTC().add(expiresIn);
      return .new(
        token: _jwtService.issueToken(
          JwtPayload(sub: userId, tokenVersion: tokenVersion),
          expiresIn: expiresIn,
        ),
        expiresAt: expiresAt,
      );
    }

    Future<AuthToken> createRefreshToken() async {
      final refreshTokenRaw = generateSecureRandomString();
      final refreshTokenHash = _hashToken(refreshTokenRaw);

      final userRefreshToken = await _userRefreshTokenRepository.create(
        userId: userId,
        tokenHash: refreshTokenHash,
        clientMetadata: metadata,
        expiresAt: _timeNowUTC().add(_refreshTokenExpiryDuration),
      );

      return .new(
        token: refreshTokenRaw,
        expiresAt: userRefreshToken.expiresAt,
      );
    }

    final accessToken = issueJwtAccessToken();
    final refreshToken = await createRefreshToken();

    return AuthTokens(accessToken: accessToken, refreshTokenRaw: refreshToken);
  }

  Future<Result<AuthTokens, RefreshTokenFailure>> refreshToken({
    required String refreshTokenRaw,
    required (String? ipAddress, String? userAgent) metadata,
  }) async {
    final refreshTokenHash = _hashToken(refreshTokenRaw);

    final userRefreshToken = await _userRefreshTokenRepository.findByTokenHash(
      refreshTokenHash,
    );
    if (userRefreshToken == null) {
      return .failure(const TokenNotFoundFailure());
    }

    final expired = _timeNowUTC().isAfter(userRefreshToken.expiresAt);
    if (expired) {
      return .failure(const TokenExpiredFailure());
    }

    final tokenVersion = await _userRepository.findTokenVersionById(
      userRefreshToken.userId,
    );
    if (tokenVersion == null) {
      // NOTE: Should not be possible in practice.
      // If the refresh token is valid and found in the database,
      // the corresponding user must exist.
      //
      // If the user was deleted, then the user refresh token should
      // also be deleted.
      return .failure(const UserMissingForValidTokenFailure());
    }

    final (String? ipAddress, String? userAgent) = (metadata.$1, metadata.$2);
    final newAuthTokens = await createAuthTokens(
      userId: userRefreshToken.userId,
      tokenVersion: tokenVersion,
      metadata: UserRefreshTokenClientMetadata(
        ipAddress: ipAddress,
        userAgent: userAgent,
        deviceId: userRefreshToken.clientMetadata.deviceId,
      ),
    );

    // Revokes the old refresh token
    await _userRefreshTokenRepository.deleteById(userRefreshToken.id);

    return .success(newAuthTokens);
  }

  Future<Result<AuthUser, AuthenticateFailure>> authenticate({
    required String accessToken,
  }) => _authenticate(
    accessToken: accessToken,
    findUserById: (userId) async {
      final user = await _userRepository.findAuthUserById(userId);
      return user;
    },
    getTokenVersion: (user) => user.tokenVersion,
  );

  /// Use [authenticate] unless you need the full [User] object.
  Future<Result<User, AuthenticateFailure>> authenticateWithFullUser({
    required String accessToken,
  }) => _authenticate(
    accessToken: accessToken,
    findUserById: (userId) async {
      final user = await _userRepository.findById(userId);
      return user;
    },
    getTokenVersion: (user) => user.tokenVersion,
  );

  Future<Result<T, AuthenticateFailure>> _authenticate<T>({
    required String accessToken,
    required Future<T?> Function(String userId) findUserById,
    required int Function(T user) getTokenVersion,
  }) async {
    final verifyResult = _jwtService.verifyToken(accessToken);

    switch (verifyResult) {
      case SuccessResult<JwtPayload, JwtValidationFailure>(:final value):
        final payload = value;

        final user = await findUserById(payload.sub);
        if (user == null) {
          return .failure(const UserDeletedFailure());
        }

        final tokenVersion = getTokenVersion(user);
        if (tokenVersion != payload.tokenVersion) {
          return .failure(const TokenVersionMismatchFailure());
        }

        return .success(user);
      case FailureResult<JwtPayload, JwtValidationFailure>(:final failure):
        return .failure(JwtValidationFailureWrapped(failure));
    }
  }

  Future<bool> logout({required String refreshTokenRaw}) async {
    final refreshTokenHash = _hashToken(refreshTokenRaw);
    return _userRefreshTokenRepository.deleteByTokenHash(refreshTokenHash);
  }
}

String _hashToken(String token) {
  final bytes = utf8.encode(token);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

/// Returns the current time in UTC.
DateTime _timeNowUTC() {
  return clock.now().toUtc();
}
