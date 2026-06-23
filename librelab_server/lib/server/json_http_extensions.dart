import 'dart:io' show HttpHeaders;

import 'package:json_utils/json_utils.dart';
import 'package:librelab_server/utils/http_status_code.dart';
import 'package:librelab_shared/result.dart';
import 'package:shelf/shelf.dart';

class InvalidJsonRequestBodyException({
  required final String message,
  required final String requestBody,
}) implements Exception {
  @override
  String toString() =>
      '$InvalidJsonRequestBodyException: $message\nBody: $requestBody';
}

class InvalidJsonRequestBodySchemaException({
  required final String message,
  required final JsonMap requestBody,
}) implements Exception {
  @override
  String toString() =>
      '$InvalidJsonRequestBodySchemaException: $message\nBody: $requestBody';
}

extension RequestX on Request {
  Future<T> readJsonBody<T>({
    required T Function(JsonMap json) fromJson,
  }) async {
    final body = await readAsString();
    switch (tryJsonParse(body, fromJson)) {
      case SuccessResult<T, JsonParseFailure>(:final value):
        return value;
      case FailureResult<T, JsonParseFailure>(:final failure):
        switch (failure) {
          case JsonDecodingFailure(:final reason):
            throw InvalidJsonRequestBodyException(
              requestBody: body,
              message: reason,
            );
          case JsonDeserializationFailure(:final reason, :final decodedJson):
            throw InvalidJsonRequestBodySchemaException(
              message: reason,
              requestBody: decodedJson,
            );
        }
    }
  }
}

extension JsonResponse on JsonMap {
  Response httpResponse(HttpStatusCode statusCode) {
    final jsonMap = this;

    return Response(
      statusCode.value,
      body: jsonEncode(jsonMap),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
  }
}
