import 'generator/generator.dart';

final List<ApiNode> _input = [
  HttpEndpoint(.post, 'handshake'),
  ApiGroup('users', [
    HttpEndpoint(.post, null),
    HttpEndpoint(.put, null),
    HttpEndpoint(.get, null),
    HttpEndpoint(.delete, null),
  ]),
];

Future<void> main() async {
  await generate(
    Config(
      input: ApiGroup(null, _input),
      dartOutput:
          'lib/src/api_endpoint_definition/api_endpoint_definitions.g.dart',
      outputClassName: 'ApiEndpointDefinitions',
      requiredTypesImport:
          'package:librelab_api_contract/src/api_endpoint_definition/types.dart',
    ),
  );
}
