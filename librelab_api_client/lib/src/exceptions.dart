/// @docImport 'librelab_api_client.dart';
library;

import 'package:api_client/api_client.dart';
import 'package:librelab_api_client/src/auth_session.dart';
import 'package:librelab_api_client/src/session_invalidation_reason.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:meta/meta.dart';

/// For authenticated requests with automatic token refresh support.
///
/// Used exclusively by [LibreLabApiClient.requestAuthenticated].
@immutable
sealed class const AuthApiException() implements Exception {
  const factory refreshTokenRequest(
    HttpResponse<ServerErrorResponse> response,
  ) = RefreshTokenRequestException;

  const factory sessionExpired(
    AuthSession session,
    SessionInvalidationReason reason,
  ) = SessionExpiredException;
}

/// Refresh-token request reached the server but returned a non-2xx response.
/// The request was made due to an expired access token.
///
/// Note: [ServerErrorResponse.code] will be passed to [AuthErrorCodes.isInvalidRefreshToken],
/// and if it returned `true`, [SessionExpiredException] will be thrown instead
/// of this exception (even if non-2xx response).
final class const RefreshTokenRequestException(
  final HttpResponse<ServerErrorResponse> response,
) extends AuthApiException {
  @override
  String toString() =>
      'RefreshTokenRequestException: The refresh token request failed (request was made due to expired access token).\n'
      'Response: $response';
}

/// The user was not found (probably deleted), or the session was revoked, or expired.
final class const SessionExpiredException(
  final AuthSession session,
  final SessionInvalidationReason reason,
) extends AuthApiException {
  @override
  String toString() =>
      'SessionExpiredException: Session has expired (re-authentication is required) for User "${session.userId}".\n'
      'Invalidation reason: $reason';
}
