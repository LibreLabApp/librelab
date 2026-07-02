/// @docImport 'librelab_api_client.dart';
library;

import 'package:api_client/api_client.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';

/// For authenticated requests with automatic token refresh support.
///
/// Used exclusively by [LibreLabApiClient.requestAuthenticated].
sealed class AuthApiException implements Exception {
  const AuthApiException();
}

/// Refresh-token request reached the server but returned a non-2xx response.
/// The request was made due to an expired access token.
///
/// Note: [ServerErrorResponse.code] will be passed to [AuthErrorCodes.isInvalidRefreshToken],
/// and if it returned `true`, [SessionExpiredException] will be thrown instead
/// of this exception (even if non-2xx response).
final class RefreshTokenRequestException extends AuthApiException {
  const RefreshTokenRequestException(this.response);

  final HttpResponse<ServerErrorResponse> response;

  @override
  String toString() =>
      '$RefreshTokenRequestException: The refresh token request failed (request was made due to expired access token).';
}

/// The user was not found (probably deleted), or the session was revoked, or expired.
final class SessionExpiredException(
  final AuthSession session,
  final SessionInvalidationReason reason,
) extends AuthApiException {
  @override
  String toString() =>
      '$SessionExpiredException: Session has expired (re-authentication is required) for User "${session.userId}". Reason: $reason';
}
