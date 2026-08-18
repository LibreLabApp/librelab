import 'package:api_client/api_client.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http show Client;
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:provider/provider.dart';

/// Provides [http.Client], [HttpApiClient], [LibreLabApiClient] and
/// [ApiRequestHandler] to descendant widgets.
class const HttpClientDepsProvider(
  final Widget child, {
  super.key,
  required final http.Client httpClient,
  required final HttpApiClient httpApiClient,
  required final LibreLabApiClient libreLabApiClient,
  required final ApiRequestHandler apiRequestHandler,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>.value(value: httpClient),
        Provider<HttpApiClient>.value(value: httpApiClient),
        Provider<LibreLabApiClient>.value(value: libreLabApiClient),
        Provider<ApiRequestHandler>.value(value: apiRequestHandler),
      ],
      child: child,
    );
  }
}
