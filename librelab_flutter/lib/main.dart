import 'dart:io' show stderr, stdout;

import 'package:connectivity_plus_linux_portal/connectivity_plus_linux_portal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalMaterialLocalizations;
import 'package:go_router/go_router.dart';
import 'package:json_storage/json_storage.dart';
import 'package:librelab_flutter/app_file_paths.dart';
import 'package:librelab_flutter/app_settings/app_settings.dart';
import 'package:librelab_flutter/app_settings/app_settings_repository.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/common/network/http_client_deps_provider.dart';
import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_flutter/common/platform/platform_check_flatpak.dart';
import 'package:librelab_flutter/common/ui/window_close_handler.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart' hide AppLocale;
import 'package:librelab_flutter/initial_setup/initial_setup_page.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:string_storage/string_storage_file.dart';
import 'package:string_storage_shared_preferences/string_storage_shared_preferences.dart';

import 'package:system_accent_color/system_accent_color.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey();

final _router = GoRouter(
  navigatorKey: _navKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const InitialSetupPage()),
  ],
);

final _logger = Logger('Main');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger((message, {required bool hasError}) {
    if (!isDesktop) {
      // ignore: avoid_print
      print(message);
    }

    if (hasError) {
      stderr.writeln(message);
    } else {
      stdout.writeln(message);
    }
  });

  if (isLinux && isFlatpak) {
    _logger.fine(
      'Using org.freedesktop.portal.NetworkMonitor for connectivity status.',
    );
    ConnectivityPlusLinuxPortalPlugin.registerWith();
  }

  final workingDirectory = kIsWeb
      ? null
      : await getApplicationSupportDirectory();
  final filePaths = AppFilePaths(workingDirectory: workingDirectory?.path);

  final StringStorage stringStorage = kIsWeb || isMobile
      ? StringStorageSharedPreferences(.new())
      : StringStorageFile((storageId) => .new(storageId));

  final jsonStorage = JsonStorage(
    storage: stringStorage,
    prettyJson: true,
    logger: Logger('$JsonStorage'),
  );

  final AppSettingsRepository repository = AppSettingsRepository(
    jsonStorage,
    filePaths.settings,
  );
  await repository.load();
  final settings = repository.cached;

  await _setLocale(settings.locale);

  final systemAccentColor = await SystemAccentColor().getAccentColor();

  runApp(
    TranslationProvider(
      child: Provider<AppFilePaths>.value(
        value: filePaths,
        child: HttpClientDepsProvider(
          BlocProvider(
            create: (context) =>
                AppSettingsCubit(repository, initial: settings),
            child: MainApp(systemAccentColor: systemAccentColor),
          ),
        ),
      ),
    ),
  );

  if (isDesktop) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentState =
          _navKey.currentState ??
          (throw StateError(
            'navigatorKey property is not set or connected to $GoRouter',
          ));
      final context = currentState.context;
      if (context.mounted) {
        setupWindowCloseHandler(context);
      }
    });
  }
}

class const MainApp({required final Color? systemAccentColor, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listTileTheme = ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
    const progressIndicatorTheme = ProgressIndicatorThemeData(
      // ignore: deprecated_member_use
      year2023: false,
    );
    const sliderTheme = SliderThemeData(
      // ignore: deprecated_member_use
      year2023: false,
    );

    return BlocListener<AppSettingsCubit, AppSettingsState>(
      listenWhen: (previous, current) =>
          previous.settings.locale != current.settings.locale,
      listener: (context, state) async {
        await _setLocale(state.settings.locale);
      },
      child: Builder(
        builder: (context) {
          final appearance = context.select(
            (AppSettingsCubit v) => v.state.settings.appearance,
          );

          ColorScheme colorScheme(Brightness brightness) =>
              ColorScheme.fromSeed(
                seedColor: () {
                  if (appearance.useSystemColors) {
                    final color = systemAccentColor;
                    if (color != null) {
                      return color;
                    }
                  }
                  if (appearance.useAccentColor) {
                    return Color(appearance.accentColor);
                  }
                  return Colors.lightBlue;
                }(),
                brightness: brightness,
              );

          return MaterialApp.router(
            routerConfig: _router,
            theme: ThemeData(
              colorScheme: colorScheme(.light),
              listTileTheme: listTileTheme,
              progressIndicatorTheme: progressIndicatorTheme,
              sliderTheme: sliderTheme,
            ),
            darkTheme: ThemeData(
              colorScheme: colorScheme(.dark),
              listTileTheme: listTileTheme,
              progressIndicatorTheme: progressIndicatorTheme,
              sliderTheme: sliderTheme,
            ),
            themeMode: switch (appearance.themeMode) {
              .system => .system,
              .dark => .dark,
              .light => .light,
            },
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: const [
              ...GlobalMaterialLocalizations.delegates,
            ],
          );
        },
      ),
    );
  }
}

Future<void> _setLocale(AppLocale? locale) async {
  if (locale == null) {
    await LocaleSettings.useDeviceLocale();
    return;
  }
  await LocaleSettings.setLocale(switch (locale) {
    .en => .en,
    .ar => .ar,
  });
}
