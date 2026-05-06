import 'dart:async';
import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalMaterialLocalizations;
import 'package:go_router/go_router.dart';
import 'package:librelab_client/librelab_client.dart';
import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_flutter/common/platform/window_close_handler.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart';
import 'package:librelab_flutter/initial_setup/initial_setup_page.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

final GlobalKey<NavigatorState> _navKey = GlobalKey();

final _router = GoRouter(
  navigatorKey: _navKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const InitialSetupPage()),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final serverUrl = await getServerUrl();

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager(
      // Workaround: accessing the macOS keychain requires an Apple account,
      // and this is a convenient workaround during development.
      // The app will not be deployed to Apple systems.
      storage: isMacOS && kDebugMode ? _FileClientAuthSuccessStorage() : null,
    );

  unawaited(client.auth.initialize());

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

class _FileClientAuthSuccessStorage implements ClientAuthSuccessStorage {
  final File _file = File('do_not_check_this_auth.json');
  @override
  Future<AuthSuccess?> get() async {
    if (!_file.existsSync()) {
      return null;
    }
    return AuthSuccess.fromJson(
      jsonDecode(await _file.readAsString()) as Map<String, Object?>,
    );
  }

  @override
  Future<void> set(AuthSuccess? data) async {
    if (data != null) {
      await _file.writeAsString(jsonEncode(data.toJson()));
    }
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        listTileTheme: listTileTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen,
          brightness: Brightness.dark,
        ),
        listTileTheme: listTileTheme,
      ),
      themeMode: .light,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
