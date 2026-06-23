import 'package:http_method/http_method.dart';
import 'package:meta/meta.dart';
export 'package:http_method/http_method.dart' show HttpMethod;

@immutable
sealed class const EndpointDefinition({required final String path});

final class const HttpEndpoint({
  required final HttpMethod method,
  required super.path,
}) extends EndpointDefinition;

final class const WebSocketEndpoint({required super.path})
    extends EndpointDefinition;
