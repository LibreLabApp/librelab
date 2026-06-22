import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

/// Lab specific settings (runtime state stored in DB. Not infrastructure config)
@immutable
class LabSettings {
  const LabSettings({required this.labName, required this.loginDisabled});

  final String? labName;
  final bool loginDisabled;
}

@immutable
class LabSettingsPatch {
  const LabSettingsPatch({
    this.labName = const .absent(),
    this.loginDisabled = const .absent(),
  });

  final Field<String?> labName;
  final Field<bool> loginDisabled;
}
