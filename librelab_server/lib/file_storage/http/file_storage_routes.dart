import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_server/file_storage/http/file_storage_controller.dart';
import 'package:librelab_server/server/request_ext.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:shelf_router/shelf_router.dart';

Router fileStorageRoutes(FileStorageController controller) => .new()
  ..register(
    ApiEndpointDefinitions.storage_file$GET(id: RouteParams.idPath),
    controller.getFile,
  )
  ..register(
    ApiEndpointDefinitions.storage$GET(id: RouteParams.idPath),
    controller.get,
  )
  ..register(ApiEndpointDefinitions.storage$POST, controller.upload)
  ..register(
    ApiEndpointDefinitions.storage$PUT(id: RouteParams.idPath),
    controller.update,
  )
  ..register(
    ApiEndpointDefinitions.storage$DELETE(id: RouteParams.idPath),
    controller.delete,
  );
