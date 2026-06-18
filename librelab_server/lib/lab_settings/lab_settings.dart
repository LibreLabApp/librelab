import 'package:meta/meta.dart';

/// Lab specific settings (runtime state stored in DB. Not infrastructure config)
@immutable
class LabSettings {
  const LabSettings({required this.labName, required this.loginDisabled});

  final String? labName;
  final bool loginDisabled;
}
