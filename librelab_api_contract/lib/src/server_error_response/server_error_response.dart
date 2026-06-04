import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'server_error_response.g.dart';

@immutable
@JsonSerializable()
class ServerErrorResponse {
  const ServerErrorResponse({
    required this.message,
    required this.code,
    this.details,
  });

  factory ServerErrorResponse.fromJson(JsonMap json) =>
      _$ServerErrorResponseFromJson(json);

  JsonMap toJson() {
    final details = this.details;
    if (details != null) {
      for (final entry in details.entries) {
        final value = entry.value;

        if (value is String || value is num || value is int || value is bool) {
          continue;
        } else {
          throw ArgumentError.value(
            value,
            'details[${entry.key}]',
            'unsupported value type: ${value.runtimeType}',
          );
        }
      }
    }

    return _$ServerErrorResponseToJson(this);
  }

  final String message;
  final String code;

  final JsonMap? details;

  ServerErrorResponse copyWith({
    String? message,
    String? code,
    JsonMap? details,
  }) {
    return ServerErrorResponse(
      message: message ?? this.message,
      code: code ?? this.code,
      details: details ?? this.details,
    );
  }

  @override
  String toString() =>
      'ServerErrorResponse(message: $message, code: $code, details: $details)';
}
