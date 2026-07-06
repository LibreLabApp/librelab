import 'package:librelab_shared/result.dart';

/// Represents infrastructure-level failures that are common to all API requests.
///
/// Endpoint-specific outcomes should be modeled separately.
sealed class const ApiRequestFailure(super.message) extends Failure;

final class const ConnectionFailure(super.message) extends ApiRequestFailure;

final class const UnexpectedFailure(super.message) extends ApiRequestFailure;

final class const UnhandledServerResponseFailure(
  final int statusCode,
  final String serverMessage,
) extends ApiRequestFailure {
  this
    : super(
        'The API server returned an unhandled error response '
        '($statusCode).\n'
        'Response body: $serverMessage',
      );
}

final class const AuthenticationFailure() extends ApiRequestFailure {
  this
    : super(
        'Authentication failure. The access token is missing, invalid or expired (unauthorized).',
      );
}

final class const AuthorizationFailure() extends ApiRequestFailure {
  this
    : super(
        'Authorization failure. The user lacks permission to perform this action (forbidden access).',
      );
}

final class const TooManyRequestsFailure() extends ApiRequestFailure {
  this : super('Too many requests have been sent');
}

final class const ServiceUnavailableFailure(final int? retryAfterInSeconds)
    extends ApiRequestFailure {
  this
    : super(
        'Service temporarily unavailable.'
        '${retryAfterInSeconds != null ? ' Retry after $retryAfterInSeconds seconds.' : ''}',
      );
}

final class const InternalServerFailure(
  final int statusCode,
  final String serverMessage,
) extends ApiRequestFailure {
  this : super('Internal server error ($statusCode): $serverMessage');
}

sealed class const InvalidJsonFailure(super.message) extends ApiRequestFailure;

final class const MalformedJsonFailure(
  final String responseBody,

  /// Message describing why the response body was considered invalid.
  final String reason,
) extends InvalidJsonFailure {
  this : super('Malformed JSON: $reason\nResponse body: $responseBody');
}

final class const JsonDeserializationFailure(
  final Object data,

  /// Message describing why the structure was considered unexpected.
  final String reason,
) extends InvalidJsonFailure {
  this : super('Unexpected JSON structure: $reason\nData: $data');
}
