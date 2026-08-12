import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';

extension ApiRequestFailureUiMessages on ApiRequestFailure {
  String getUiMessage(Translations translations) {
    final t = translations.apiRequestFailures;
    return switch (this) {
      ConnectionFailure() => t.connection,
      UnexpectedFailure() => t.unexpected,
      UnhandledServerResponseFailure() => t.unhandledServerResponse,
      UnauthorizedFailure() => t.unauthorized,
      AccessForbiddenFailure() => t.accessForbidden,
      TooManyRequestsFailure() => t.tooManyRequests,
      ServiceUnavailableFailure() => t.serviceUnavailable,
      InternalServerFailure() => t.internalServer,
      MalformedJsonFailure() => t.malformedJson,
      JsonDeserializationFailure() => t.jsonDeserialization,
    };
  }
}
