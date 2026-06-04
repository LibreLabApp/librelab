import 'package:http_method/http_method.dart';
export 'package:http_method/http_method.dart' show HttpMethod;

sealed class EndpointDefinition {
  const EndpointDefinition({required this.path});

  final String path;
}

final class HttpEndpoint extends EndpointDefinition {
  const HttpEndpoint({required this.method, required super.path});

  final HttpMethod method;
}

final class WebSocketEndpoint extends EndpointDefinition {
  const WebSocketEndpoint({required super.path});
}
