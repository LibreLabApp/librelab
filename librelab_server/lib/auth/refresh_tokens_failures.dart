import 'package:librelab_shared/result.dart';

sealed class RefreshTokensFailures extends Failure {
  const RefreshTokensFailures();
}

final class TokenNotFoundFailure extends RefreshTokensFailures {
  const TokenNotFoundFailure();
}

final class TokenExpiredFailure extends RefreshTokensFailures {
  const TokenExpiredFailure();
}

final class UserMissingForValidTokenFailure extends RefreshTokensFailures {
  const UserMissingForValidTokenFailure();
}
