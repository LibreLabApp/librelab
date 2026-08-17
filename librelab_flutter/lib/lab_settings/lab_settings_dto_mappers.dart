import 'package:librelab_api_contract/librelab_api_contract.dart' as api;
import 'package:librelab_flutter/lab_settings/models/lab_settings.dart';

extension LabSettingsDtoMappers on api.LabSettingsResponse {
  LabSettings toDomain() =>
      .new(labName: labName, loginDisabled: loginDisabled);
}
