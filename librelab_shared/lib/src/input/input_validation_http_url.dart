part of 'input_validation.dart';

@immutable
sealed class const HttpUrlValidationFailure();

final class const InvalidUri() extends HttpUrlValidationFailure;

final class const MissingScheme() extends HttpUrlValidationFailure;

final class const UnsupportedScheme(final String scheme)
    extends HttpUrlValidationFailure;

final class const MissingAuthority() extends HttpUrlValidationFailure;

final class const MissingHost() extends HttpUrlValidationFailure;

final class const InvalidPort(final int port) extends HttpUrlValidationFailure;

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
