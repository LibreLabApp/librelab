import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:librelab_shared/result.dart';
import 'package:meta/meta.dart';

sealed class JwtValidationFailure extends Failure {}

class JwtInvalidFailure extends JwtValidationFailure {}

class JwtExpiredFailure extends JwtValidationFailure {}

class JwtService {
  JwtService({required String jwtAccessTokenSecret})
    : _jwtAccessTokenSecret = SecretKey(jwtAccessTokenSecret);

  final SecretKey _jwtAccessTokenSecret;

  String issueToken(JwtPayload payload, {Duration? expiresIn}) {
    final jwt = JWT(payload.toMap());
    return jwt.sign(_jwtAccessTokenSecret, expiresIn: expiresIn);
  }

  Result<JwtPayload, JwtValidationFailure> verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, _jwtAccessTokenSecret);
      return .success(JwtPayload.fromMap(jwt.payload as Map<String, Object?>));
    } on JWTExpiredException {
      return .failure(JwtExpiredFailure());
    } on JWTException {
      return .failure(JwtInvalidFailure());
    }
  }
}

@immutable
class JwtPayload {
  const JwtPayload({required this.sub, required this.tokenVersion});

  factory JwtPayload.fromMap(Map<String, Object?> map) => JwtPayload(
    sub: map['sub']! as String,
    tokenVersion: map['token_version']! as int,
  );

  final String sub;
  final int tokenVersion;

  Map<String, Object?> toMap() => {'sub': sub, 'token_version': tokenVersion};
}
