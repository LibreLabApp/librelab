import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';

extension ApiRequestFailureUiMessages on ApiRequestFailure {
  String getUiMessage(Translations translations) {
    final t = translations.apiRequestFailures;
    return switch (this) {
      ConnectionFailure() => t.connectionFailure,
      UnexpectedFailure() => t.unexpectedFailure,
      UnhandledServerResponseFailure() => t.unhandledServerResponseFailure,
      AuthenticationFailure() => t.authenticationFailure,
      AuthorizationFailure() => t.authorizationFailure,
      TooManyRequestsFailure() => t.tooManyRequestsFailure,
      ServiceUnavailableFailure() => t.serviceUnavailableFailure,
      InternalServerFailure() => t.internalServerFailure,
      MalformedJsonFailure() => t.malformedJsonFailure,
      JsonDeserializationFailure() => t.jsonDeserializationFailure,
    };
  }
}
