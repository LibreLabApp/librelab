import 'dart:io' show Platform, stderr, stdout;

import 'package:connectivity_plus_linux_portal/connectivity_plus_linux_portal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalMaterialLocalizations;
import 'package:go_router/go_router.dart';

import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_flutter/common/ui/window_close_handler.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart';
import 'package:librelab_flutter/initial_setup/initial_setup_page.dart';
import 'package:logging/logging.dart';

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

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final level = record.level;
    final message = '${record.level.name}: ${record.time}: ${record.message}';

    final errorLevels = {Level.WARNING, Level.SEVERE, Level.SHOUT};

    if (errorLevels.contains(level)) {
      final errorMessage =
          '$message\n'
          '  Error: ${record.error}\n'
          '  StackTrace: ${record.stackTrace}\n';

      if (isDesktop) {
        stderr.writeln(errorMessage);
      } else {
        // ignore: avoid_print
        print(errorMessage);
      }
    } else {
      if (isDesktop) {
        stdout.writeln(message);
      } else {
        // ignore: avoid_print
        print(message);
      }
    }
  });

  if (isLinux) {
    _maybeUseNetworkMonitorPortal();
  }

  await LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const MainApp()));

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

void _maybeUseNetworkMonitorPortal() {
  final backend = Platform.environment['CONNECTIVITY_BACKEND'];
  final usePortal = isFlatpak || backend == 'portal';

  if (usePortal) {
    _logger.fine(
      'Using org.freedesktop.portal.NetworkMonitor for connectivity status.',
    );
    ConnectivityPlusLinuxPortalPlugin.registerWith();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final listTileTheme = ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          brightness: .light,
        ),
        listTileTheme: listTileTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: .dark,
        ),
        listTileTheme: listTileTheme,
      ),
      themeMode: .system,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
