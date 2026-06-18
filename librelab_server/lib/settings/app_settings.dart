import 'package:meta/meta.dart';

/// Application settings (runtime state stored in DB. Not infrastructure config)
@immutable
class AppSettings {
  const AppSettings({required this.labName, required this.loginDisabled});

  final String? labName;
  final bool loginDisabled;
}
