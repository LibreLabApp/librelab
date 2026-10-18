import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_server/auth/http/auth_controller.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:shelf_router/shelf_router.dart';

Router authRoutes(AuthController controller) => .new()
  ..register(ApiEndpointDefinitions.auth_login$POST, controller.login)
  ..register(ApiEndpointDefinitions.auth_refresh$POST, controller.refresh)
  ..register(ApiEndpointDefinitions.auth_logout$POST, controller.logout)
  ..register(
    ApiEndpointDefinitions.auth_browser_login$POST,
    controller.browser.login,
  )
  ..register(
    ApiEndpointDefinitions.auth_browser_refresh$POST,
    controller.browser.refresh,
  )
  ..register(
    ApiEndpointDefinitions.auth_browser_logout$POST,
    controller.browser.logout,
  )
  ..register(
    ApiEndpointDefinitions.auth_login_status$GET,
    controller.loginStatus,
  );
