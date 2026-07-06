import 'package:librelab_api_client/src/endpoints/compatibility_endpoints.dart';
import 'package:librelab_api_client/src/librelab_api_client.dart';

class Endpoints(LibreLabApiClient client) {
  final compatibility = CompatibilityEndpoints(client);
}
