import 'package:meta/meta.dart';

export 'package:email_validator/email_validator.dart' show EmailValidator;

part 'input_validation_http_url.dart';

const _maxTcpUdpPort = 65535;

bool isValidPort(int port) {
  return port > 0 && port <= _maxTcpUdpPort;
}

bool hasScheme(String value) {
  final hasScheme = RegExp('^[a-zA-Z][a-zA-Z0-9+.-]*://').hasMatch(value);
  return hasScheme;
}
