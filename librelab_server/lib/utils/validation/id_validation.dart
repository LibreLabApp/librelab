import 'package:meta/meta.dart';
import 'package:uuid/uuid_value.dart';

bool _isValidUuid(String value) {
  try {
    UuidValue.withFormatValidation(value);
    return true;
  } on FormatException {
    return false;
  }
}

/// Validates a UUID before passing it to the database using this method.
/// An invalid UUID would otherwise cause an unhandled database exception.
///
/// Throws [InvalidUuidException] if [id] is not a valid UUID.
void validateId(String id) {
  if (!_isValidUuid(id)) {
    throw InvalidUuidException(id);
  }
}

@immutable
final class const InvalidUuidException(final String id) implements Exception;
