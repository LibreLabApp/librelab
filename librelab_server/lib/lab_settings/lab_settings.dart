import 'package:meta/meta.dart';
import 'package:optional_field/optional_field.dart';

/// Lab specific settings (runtime state stored in DB. Not infrastructure config)
@immutable
class const LabSettings({
  required final int id, // Singleton
  required final String? labName,
  required final bool loginDisabled,
}) {
  Map<String, Object?> toAuditJson() => {
    'labName': labName,
    'loginDisabled': loginDisabled,
  };
}

@immutable
class const LabSettingsPatch({
  final Field<String?> labName = const .absent(),
  final Field<bool> loginDisabled = const .absent(),
});
