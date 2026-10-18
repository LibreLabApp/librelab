import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_server/compatibility/http/compatibility_controller.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:shelf_router/shelf_router.dart';

Router compatibilityRoutes(CompatibilityController controller) => .new()
  ..register(ApiEndpointDefinitions.compatibility_check$POST, controller.check);
