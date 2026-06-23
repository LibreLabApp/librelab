import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:librelab_api_contract/src/types/json_types.dart';
import 'package:meta/meta.dart';

part 'server_error_response.g.dart';

@immutable
@JsonSerializable()
class const ServerErrorResponse({
  required final String message,
  required final String code,
  final JsonMap? details,
}) {
  factory fromJson(JsonMap json) => _$ServerErrorResponseFromJson(json);
  JsonMap toJson() {
    // Validates the values
    final details = this.details;
    if (details != null) {
      for (final entry in details.entries) {
        final value = entry.value;

        if (value == null ||
            value is String ||
            value is num ||
            value is int ||
            value is bool ||
            value is List<String>) {
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerErrorResponse &&
          message == other.message &&
          code == other.code &&
          const DeepCollectionEquality().equals(details, other.details);

  @override
  int get hashCode =>
      Object.hash(message, code, const DeepCollectionEquality().hash(details));

  @override
  String toString() =>
      'ServerErrorResponse(message: $message, code: $code, details: $details)';
}
