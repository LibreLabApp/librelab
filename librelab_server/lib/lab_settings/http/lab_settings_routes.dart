import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_server/lab_settings/http/lab_settings_controller.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:shelf_router/shelf_router.dart';

Router labSettingsRoutes(LabSettingsController controller) => .new()
  ..register(ApiEndpointDefinitions.lab_settings$GET, controller.get)
  ..register(ApiEndpointDefinitions.lab_settings$PATCH, controller.update);
