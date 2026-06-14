import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:librelab_server/auth/security/jwt/jwt_validation_failures.dart';
import 'package:librelab_shared/result.dart';
import 'package:meta/meta.dart';

export 'package:librelab_server/auth/security/jwt/jwt_validation_failures.dart';

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
      return .failure(const JwtExpiredFailure());
    } on JWTInvalidException catch (e) {
      // When optional parameters (e.g., issuer) are not provided to JWT.verify(),
      // it will typically throw a JWTInvalidException when there is a
      // JWT format error except for the "invalid signature" case:
      // https://github.com/jonasroussel/dart_jsonwebtoken/blob/89dd3cfcd283945790d50cdaf346de908ee59d81/lib/src/jwt.dart#L61
      if (e.message.toLowerCase().contains('invalid signature'.toLowerCase())) {
        return .failure(const JwtSignatureVerificationFailure());
      }

      return .failure(const JwtParseFailure());
    } on JWTException catch (e) {
      return .failure(JwtUnknownFailure(e.toString()));
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
