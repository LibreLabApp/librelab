import 'package:flutter/material.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart'
    show Translations;

export 'package:librelab_flutter/generated/i18n/strings.g.dart'
    show Translations;

extension BuildContextExt on BuildContext {
  Translations get t => Translations.of(this);

  ThemeData get theme => Theme.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  bool get isDark => theme.isDark;
}

extension ThemeDataExt on ThemeData {
  bool get isDark => brightness == Brightness.dark;
}
