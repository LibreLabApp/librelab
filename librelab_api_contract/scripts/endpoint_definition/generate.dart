import 'generator/generator.dart';

final List<ApiNode> _input = [
  HttpEndpoint(.post, 'handshake'),
  ApiGroup('auth', [
    HttpEndpoint(.post, 'login'),
    HttpEndpoint(.post, 'logout'),
    HttpEndpoint(.post, 'refresh-token'),
    HttpEndpoint(.post, 'refresh-user'),
  ]),
  ApiGroup('lab-settings', [
    HttpEndpoint(.patch, null),
    HttpEndpoint(.get, null),
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
