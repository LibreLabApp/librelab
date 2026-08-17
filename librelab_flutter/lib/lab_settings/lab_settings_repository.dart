import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:librelab_flutter/lab_settings/lab_settings_dto_mappers.dart';
import 'package:librelab_flutter/lab_settings/models/lab_settings.dart';

class LabSettingsRepository({
  required final LabSettingsEndpoints _labSettingsEndpoints,
  required final ApiRequestHandler _handler,
}) {
  LabSettingsEndpoints get _endpoints => _labSettingsEndpoints;

  Future<ApiRequestResult<LabSettings>> get() => _handler.execute(
    () => _endpoints.get(),
    mapSuccess: (dto) => dto.toDomain(),
  );

  Future<ApiRequestResult<LabSettings>> update({required String labName}) =>
      _handler.execute(
        () => _endpoints.update(.new(labName: labName, loginDisabled: null)),
        mapSuccess: (dto) => dto.toDomain(),
      );
}
