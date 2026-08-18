import 'package:librelab_flutter/generated/i18n/strings.g.dart'
    show Translations;
import 'package:material_ui/material_ui.dart';

export 'package:librelab_flutter/generated/i18n/strings.g.dart'
    show Translations;

extension BuildContextExt on BuildContext {
  Translations get t => Translations.of(this);

  ThemeData get theme => Theme.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  bool get isDark => theme.isDark;

  void showSnackBarMessage(
    String message, {
    Duration? duration,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this)
        .showSnackBar(SnackBar(content: Text(message), action: action));
  }
}

extension ThemeDataExt on ThemeData {
  bool get isDark => brightness == Brightness.dark;
}
