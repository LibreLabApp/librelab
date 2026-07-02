import 'package:http_method_enum/http_method_enum.dart' show HttpMethod;
import 'package:meta/meta.dart';
export 'package:http_method_enum/http_method_enum.dart' show HttpMethod;

@immutable
sealed class const EndpointDefinition({required final String path});

final class const HttpEndpoint({
  required final HttpMethod method,
  required super.path,
}) extends EndpointDefinition;

final class const WebSocketEndpoint({required super.path})
    extends EndpointDefinition;
