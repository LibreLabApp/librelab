import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:librelab_server/utils/http_status_code.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class PingRoute implements RouteModule {
  @override
  Router get router =>
      .new()..register(ApiEndpointDefinitions.ping$HEAD, _handler);

  Future<Response> _handler(Request request) async =>
      Response(HttpStatusCode.noContent.value);
}
