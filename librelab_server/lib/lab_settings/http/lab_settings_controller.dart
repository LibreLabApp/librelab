import 'package:librelab_api_contract/librelab_api_contract.dart' as api;
import 'package:librelab_api_contract/librelab_api_contract.dart'
    show UpdateLabSettingsRequest;
import 'package:librelab_server/auth/authorization_service.dart';
import 'package:librelab_server/lab_settings/lab_settings.dart';
import 'package:librelab_server/lab_settings/lab_settings_service.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/server/request_ext.dart';
import 'package:shelf/shelf.dart';

class LabSettingsController({
  required final AuthorizationService _authorization,
  required final LabSettingsService _service,
}) {
  Future<Response> get(Request request) =>
      _authorization.withAuthUser(request, (_) {
        return _service.cached.toResponse().toJson().httpResponse(.ok);
      });

  Future<Response> update(Request request) =>
      _authorization.withPermission(request, .labSettingsUpdate, (user) async {
        final body = await request.readJsonBody(
          fromJson: UpdateLabSettingsRequest.fromJson,
        );

        final updated = await _service.update(
          .new(
            labName: .fromNullable(body.labName),
            loginDisabled: .fromNullable(body.loginDisabled),
            labImageId: .fromNullable(body.labImageId),
          ),
          userId: user.id,
          requestMetadata: request.requestMetadata,
        );

        return updated.toResponse().toJson().httpResponse(.ok);
      });
}

extension on LabSettings {
  api.LabSettings toResponse() => .new(
    labName: labName,
    loginDisabled: loginDisabled,
    labImageId: labImageId,
    updatedAt: updatedAt,
  );
}
