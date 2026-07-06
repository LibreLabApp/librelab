import 'package:api_client/api_client.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http show Client;
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:librelab_flutter/common/network/http_client_factory/http_client_factory.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

/// Provides [http.Client], [HttpApiClient] and [LibreLabApiClient]
/// to descendant widgets.
class const HttpClientDepsProvider(final Widget child, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(
          create: (_) => createHttpClient(),
          dispose: (_, client) => client.close(),
        ),
        Provider<HttpApiClient>(
          create: (context) => HttpApiClientDart(context.read<http.Client>()),
        ),
        Provider<LibreLabApiClient>(
          create: (context) => LibreLabApiClient(
            apiClient: context.read<HttpApiClient>(),
            logger: Logger('$LibreLabApiClient'),
            // TODO: Implement later
            onAuthSessionRefreshed: null,
          ),
        ),
        Provider<ApiRequestHandler>(
          create: (context) => ApiRequestHandlerDefault(),
        ),
      ],
      child: child,
    );
  }
}
