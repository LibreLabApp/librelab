import 'package:librelab_flutter/app_settings/app_settings.dart';

extension AppLocaleLabels on AppLocale {
  /// The language name in its native form (endonym).
  String get label => switch (this) {
    .en => 'English',
    .ar => 'العربية',
  };
}
