import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_server/auth/authorization_service.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:librelab_server/user/mapper.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class UserRoutes({required final AuthorizationService _authorization})
    implements RouteModule {
  @override
  Router get router =>
      .new()
        ..register(ApiEndpointDefinitions.users_me$GET, _getCurrentUserHandler);

  Future<Response> _getCurrentUserHandler(Request request) =>
      _authorization.withFullUser(request, (user) async {
        return user.toResponse().toJson().httpResponse(.ok);
      });
}
