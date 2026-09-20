import 'generator/generator.dart';

final List<ApiNode> _input = [
  ApiGroup('compatibility', [HttpEndpoint(.post, 'check')]),
  ApiGroup('auth', [
    HttpEndpoint(.get, 'login-status'),
    HttpEndpoint(.post, 'login'),
    HttpEndpoint(.post, 'logout'),
    HttpEndpoint(.post, 'refresh'),
    // Important: 'auth/browser/' is hardcoded in auth_browser_routes.dart
    ApiGroup('browser', [
      // These endpoints exist because their authentication contract
      // depends on browser-specific capabilities (i.e., HttpOnly cookies).
      HttpEndpoint(.post, 'login'),
      HttpEndpoint(.post, 'logout'),
      HttpEndpoint(.post, 'refresh'),
    ]),
  ]),
  ApiGroup('users', [HttpEndpoint(.get, 'me')]),
  ApiGroup('lab-settings', [
    HttpEndpoint(.get, null),
    HttpEndpoint(.patch, null),
  ]),
  ApiGroup('storage', [
    HttpEndpoint(.get, pathParam('id')),
    HttpEndpoint(.post, null),
    HttpEndpoint(.put, pathParam('id')),
    HttpEndpoint(.delete, pathParam('id')),
  ]),
];

Future<void> main() async {
  await generate(
    Config(
      input: ApiGroup(null, _input),
      dartOutput:
          'lib/src/api_endpoint_definition/api_endpoint_definitions.g.dart',
      outputClassName: 'ApiEndpointDefinitions',
      requiredTypesImport: 'package:librelab_api_contract/src/api_endpoint_definition/types.dart',
    ),
  );
}
