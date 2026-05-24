part of 'input_validation.dart';

@immutable
sealed class HttpUrlValidationFailure {
  const HttpUrlValidationFailure();
}

final class InvalidUri extends HttpUrlValidationFailure {
  const InvalidUri();
}

final class MissingScheme extends HttpUrlValidationFailure {
  const MissingScheme();
}

final class UnsupportedScheme extends HttpUrlValidationFailure {
  const UnsupportedScheme(this.scheme);
  final String scheme;
}

final class MissingAuthority extends HttpUrlValidationFailure {
  const MissingAuthority();
}

final class MissingHost extends HttpUrlValidationFailure {
  const MissingHost();
}

final class InvalidPort extends HttpUrlValidationFailure {
  const InvalidPort(this.port);
  final int port;
}

HttpUrlValidationFailure? validateHttpUrl(String input) {
  final uri = Uri.tryParse(input);
  if (uri == null) {
    return const InvalidUri();
  }

  if (!uri.hasScheme) {
    return const MissingScheme();
  }

  final allowed = {'http', 'https'};

  if (!allowed.contains(uri.scheme)) {
    return UnsupportedScheme(uri.scheme);
  }

  if (!uri.hasAuthority) {
    return const MissingAuthority();
  }

  if (uri.host.isEmpty) {
    return const MissingHost();
  }
  if (uri.hasPort && !isValidPort(uri.port)) {
    return InvalidPort(uri.port);
  }
  return null;
}
