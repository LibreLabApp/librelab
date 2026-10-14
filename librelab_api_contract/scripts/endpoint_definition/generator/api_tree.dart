part of 'generator.dart';

sealed class const ApiNode();

final class const ApiGroup(final String? segment, final List<ApiNode> children)
    extends ApiNode;

sealed class EndpointDefinition extends ApiNode {
  new(
    // String | List<String> | null
    Object? path,
  ) : path = switch (path) {
        String s => [s],
        List<String> l => l,
        List<dynamic> l => l.cast(),
        null => [],
        Object() => throw ArgumentError.value(
          path,
          'path',
          'Must be a String or List<String> or null. Received: ${path.runtimeType}',
        ),
      };

  final List<String> path;
}

final class HttpEndpoint extends EndpointDefinition {
  new(this.method, super.path);

  final HttpMethod method;
}

final class WebSocketEndpoint extends EndpointDefinition {
  new(super.path);
}

/// Formats a parameter name as a path placeholder.
///
/// Example: `userId` -> `{userId}`
///
/// Path placeholders are later detected by [_hasPathParams],
/// extracted via [_extractPathParams], and converted to Dart
/// interpolation by [_dartifyPathTemplate] to allow consumers
/// replacing the placeholder in a type-safe manner.
String pathParam(String parameterName) {
  return '{$parameterName}';
}
