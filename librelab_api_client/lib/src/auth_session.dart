import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:meta/meta.dart';

@immutable
class const AuthSession({
  required final String userId,
  required final AuthToken accessToken,
  required final AuthToken refreshToken,
}) {
  AuthSession copyWith({
    required AuthToken accessToken,
    required AuthToken refreshToken,
  }) {
    return AuthSession(
      userId: userId,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
