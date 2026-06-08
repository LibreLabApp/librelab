import 'dart:collection';
import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:http_method/http_method.dart';
import 'package:meta/meta.dart';
import '../../../../scripts/_utils.dart';

part 'api_tree.dart';
part 'config.dart';
part 'internal_utils.dart';
part 'required_types.dart';

Future<void> generate(Config config) async {
  final outputFile = File(config.dartOutput);
  if (!outputFile.existsSync()) {
    stderr.writeln('An empty file must exist: ${config.dartOutput}');
    exit(1);
  }

  final endpoints = _flatten(config.input);

  final generatedCode = _generateDartCode(
    config,
    endpoints: UnmodifiableListView(endpoints),
  );

  await outputFile.writeAsString(generatedCode);

  stdout.writeln('Generated ${config.dartOutput}.');
}

String _generateDartCode(
  Config config, {
  required UnmodifiableListView<(EndpointDefinition, String)> endpoints,
}) {
  final fields = <Field>[];
  final methods = <Method>[];

  _buildEndpointMembers(
    endpoints,
    addField: (field) => fields.add(field),
    addMethod: (method) => methods.add(method),
  );

  final apiEndpointsContract = Class(
    (b) => b
      ..name = config.outputClassName
      ..abstract = true
      ..modifier = ClassModifier.final$
      ..constructors.clear()
      ..fields.addAll(fields)
      ..methods.addAll(methods)
      ..docs.addAll([
        '/// Generated code. Do not **modify** directly.',
        '///',
        '/// Shared type-safe definition of client-server endpoints (HTTP or WebSocket).',
        '/// Each endpoint includes URL path and/or HTTP method (if endpoint is HTTP).',
        '///',
        '/// The server exposes/implements the API, and the API client consumes it.',
        '/// This contract does not include request/response schemas, headers, or other metadata.',
      ]),
  );

  final emitter = DartEmitter();

  final library = Library(
    (b) => b
      ..directives.add(Directive.import(config.requiredTypesImport))
      ..docs.addAll([
        '// coverage:ignore-file',
        '/// Generated code. Do not modify directly.',
        '/// Instead, modify and then run: dart $scriptRelativePath',
      ])
      ..body.addAll([apiEndpointsContract]),
  );

  return DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
  ).format('${library.accept(emitter)}');
}

void _buildEndpointMembers(
  List<(EndpointDefinition, String)> endpoints, {
  required void Function(Method method) addMethod,
  required void Function(Field field) addField,
}) {
  for (final (endpoint, path) in endpoints) {
    final type = switch (endpoint) {
      HttpEndpoint() => _httpEndpointReference,
      WebSocketEndpoint() => _webSocketEndpointReference,
    };

    Expression buildExpression([String Function(String path)? mapPath]) {
      final pathValue = literalString(mapPath?.call(path) ?? path);

      return type.newInstance([], switch (endpoint) {
        HttpEndpoint(:final method) => {
          'method': _httpMethodReference.property(method.name),
          'path': pathValue,
        },
        WebSocketEndpoint() => {'path': pathValue},
      });
    }

    final comment =
        '${switch (endpoint) {
          HttpEndpoint(:final method) => 'HTTP ${method.name.toUpperCase()}',
          WebSocketEndpoint() => 'WS',
        }} $path';

    final memberName = _buildDartEndpointIdentifier(
      endpoint: endpoint,
      path: path,
    );

    final hasPathParams = _hasPathParams(path);
    if (!hasPathParams) {
      final field = Field(
        (b) => b
          ..name = memberName
          ..static = true
          ..modifier = FieldModifier.constant
          ..type = type
          ..assignment = buildExpression().code
          ..docs.add('/// $comment'),
      );
      addField(field);
      continue;
    }

    final pathParams = _extractPathParams(path);

    final method = Method(
      (b) => b
        ..name = memberName
        ..static = true
        ..returns = type
        // "optionalParameters" is a slightly misleading name?
        ..optionalParameters.addAll(
          pathParams
              .map(
                (pathParam) => Parameter(
                  (b) => b
                    ..name = pathParam
                    ..named = true
                    ..required = true
                    ..type = _stringReference,
                ),
              )
              .toList(),
        )
        ..body = buildExpression((path) => _dartifyPathTemplate(path)).code
        ..docs.add('/// $comment'),
    );
    addMethod(method);
  }
}
