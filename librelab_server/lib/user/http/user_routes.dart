import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:librelab_server/user/http/user_controller.dart';
import 'package:shelf_router/shelf_router.dart';

Router userRoutes(UserController controller) => .new()
  ..register(ApiEndpointDefinitions.users_me$GET, controller.getCurrentUser);
