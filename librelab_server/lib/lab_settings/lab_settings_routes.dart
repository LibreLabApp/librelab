import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/auth/authorization_service.dart';
import 'package:librelab_server/lab_settings/lab_settings.dart';
import 'package:librelab_server/lab_settings/lab_settings_repository.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/router_ext.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LabSettingsRoutes implements RouteModule {
  LabSettingsRoutes({required this._authorization, required this._repository});

  final AuthorizationService _authorization;
  final LabSettingsRepository _repository;

  @override
  Router get router => Router()
    ..register(ApiEndpointDefinitions.lab_settings$GET, _getHandler)
    ..register(ApiEndpointDefinitions.lab_settings$PATCH, _patchHandler);

  Future<Response> _getHandler(Request request) =>
      _authorization.withAuthUser(request, (_) {
        return _repository.cached.toResponse().toJson().httpResponse(.ok);
      });

  Future<Response> _patchHandler(Request request) =>
      _authorization.withPermission(request, .labSettingsUpdate, (_) async {
        final body = await request.readJsonBody(
          fromJson: UpdateLabSettingsRequest.fromJson,
        );

        final updated = await _repository.update(
          .new(
            labName: .fromNullable(body.labName),
            loginDisabled: .fromNullable(body.loginDisabled),
          ),
        );

        return updated.toResponse().toJson().httpResponse(.ok);
      });
}

extension on LabSettings {
  LabSettingsResponse toResponse() =>
      .new(labName: labName, loginDisabled: loginDisabled);
}
