import 'package:api_client/api_client.dart';
import 'package:http/http.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_flutter/common/json_types.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_shared/result.dart';
import 'package:logging/logging.dart';

typedef ApiRequestResult<T> = Result<T, ApiRequestFailure>;

abstract interface class ApiRequestHandler {
  Future<ApiRequestResult<R>> execute<S, R>(
    Future<LibreLabApiResult<S>> Function() request, {
    required R Function(S dto) mapSuccess,
    R? Function(HttpResponse<ServerErrorResponse> error)? mapHttpError,
  });
}

class ApiRequestHandlerDefault({required final Logger _logger})
    implements ApiRequestHandler {
  @override
  Future<ApiRequestResult<R>> execute<S, R>(
    Future<LibreLabApiResult<S>> Function() request, {

    required R Function(S success) mapSuccess,
    R? Function(HttpResponse<ServerErrorResponse> error)? mapHttpError,
  }) async {
    try {
      final response = await request();
      switch (response) {
        case HttpStatusSuccess(:final response):
          return .success(mapSuccess(response.body));
        case HttpStatusError(:final response):
          final handled = mapHttpError?.call(response);
          if (handled != null) {
            return .success(handled);
          }
          return .failure(_mapHttpStatusToFailure(response));
      }
    } on ClientException catch (e) {
      return .failure(ConnectionFailure(e.toString()));
    } on JsonParseException catch (e) {
      return .failure(switch (e) {
        JsonDecodingException(:final source, :final reason) =>
          MalformedJsonFailure(source, reason),

        JsonObjectExpectedException(:final source, :final actualType) =>
          MalformedJsonFailure(
            source,
            'Expected a JSON object ($JsonMap) but got $actualType.\n',
          ),

        JsonDeserializationException(:final decodedJson, :final reason) =>
          JsonDeserializationFailure(decodedJson, reason),
      });
    } on Exception catch (e, stackTrace) {
      _logger.warning(
        'Caught an unhandled exception while sending an API request',
        e,
        stackTrace,
      );

      return .failure(UnexpectedFailure(e.toString()));
    }
  }

  ApiRequestFailure _mapHttpStatusToFailure(
    HttpResponse<ServerErrorResponse> response,
  ) {
    final (statusCode, headers) = (response.statusCode, response.headers);

    if (statusCode == HttpStatusCodes.tooManyRequests) {
      return const TooManyRequestsFailure();
    }
    if (statusCode == HttpStatusCodes.unauthorized) {
      return const AuthenticationFailure();
    }
    if (statusCode == HttpStatusCodes.forbidden) {
      return const AuthorizationFailure();
    }

    if (statusCode == HttpStatusCodes.serviceUnavailable) {
      final retryAfterHeader = headers[HttpHeaderNames.retryAfter];
      return ServiceUnavailableFailure(
        retryAfterHeader != null ? int.tryParse(retryAfterHeader) : null,
      );
    }
    if (statusCode >= 500 && statusCode < 600) {
      return InternalServerFailure(statusCode, response.body.message);
    }
    return UnhandledServerResponseFailure(statusCode, response.body.message);
  }
}
