part of 'generator.dart';

List<(EndpointDefinition endpoint, String path)> _flatten(
  ApiNode node, [
  List<String> parentPathSegments = const [],
]) {
  switch (node) {
    case ApiGroup():
      final next = [...parentPathSegments, ?node.segment];
      return node.children
          .expand((childNode) => _flatten(childNode, next))
          .toList();
    case EndpointDefinition():
      return [
        (node, _joinPath([...parentPathSegments, ...node.path])),
      ];
  }
}

String _joinPath(List<String> segments) => '/${segments.join('/')}';

final _pathParamRegex = RegExp(r'\{([^}]+)\}');

/// Checks if a path contains `{param}` segments.
///
/// Example:
///
/// - `/handshake`: `false`
/// - `/users/{userId}`
bool _hasPathParams(String path) {
  return _pathParamRegex.hasMatch(path);
}

/// Extracts `{param}` names from a URL path.
///
/// Example: `/users/{userId}/blogs/{blogId}` -> [userId, blogId]
///
/// See also: [_hasPathParams]
List<String> _extractPathParams(String path) {
  final result = <String>[];

  for (final part in path.split('/')) {
    if (part.startsWith('{') && part.endsWith('}')) {
      result.add(part.substring(1, part.length - 1));
    }
  }

  return result;
}

/// Converts `{param}` segments into Dart string interpolation.
///
/// Example: `/users/{userId}` -> `/users/${userId}`
///
/// Used for endpoint methods only.
String _dartifyPathTemplate(String path) {
  return path.replaceAllMapped(
    RegExp(r'\{([^}]+)\}'),
    (match) => '\${${match.group(1)}}',
  );
}

/// Builds the Dart member (method/field) name in the generated code.
String _buildDartEndpointIdentifier({
  required EndpointDefinition endpoint,
  required String path,
}) {
  final buffer = StringBuffer();

  final segments = path.split('/').where((e) => e.isNotEmpty);

  for (final segment in segments) {
    if (segment.startsWith('{') && segment.endsWith('}')) {
      // Skip path params
      continue;
    }

    if (segment != segments.first) {
      buffer.write('_');
    }
    buffer.write(segment);
  }

  buffer.write(r'$');

  switch (endpoint) {
    case HttpEndpoint(:final method):
      buffer.write(method.name.toUpperCase());
    case WebSocketEndpoint():
      buffer.write('WS');
  }

  return buffer.toString().replaceAll('-', '_');
}
