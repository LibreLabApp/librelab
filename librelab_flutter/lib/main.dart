import 'dart:async';
import 'dart:convert';
import 'dart:io' show File, RawDatagramSocket, stderr, stdout;

import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalMaterialLocalizations;
import 'package:go_router/go_router.dart';
import 'package:librelab_client/librelab_client.dart';
import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_flutter/common/platform/window_close_handler.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart';
import 'package:librelab_flutter/initial_setup/initial_setup_page.dart';
import 'package:librelab_flutter/local_network_discovery/cubit/local_discovery_cubit.dart';
import 'package:librelab_flutter/local_network_discovery/repository.dart';
import 'package:logging/logging.dart';
import 'package:multicast_dns/multicast_dns.dart';
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

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final level = record.level;

    final message = '${record.level.name}: ${record.time}: ${record.message}';
    if (isDesktop) {
      final errorLevels = {Level.WARNING, Level.SEVERE, Level.SHOUT};
      if (errorLevels.contains(level)) {
        stderr.writeln(message);
      } else {
        stdout.writeln(message);
      }
    } else {
      // ignore: avoid_print
      print(message);
    }
  });

  if (isIos) {
    // https://pub.dev/packages/dart_ping_ios
    DartPingIOS.register();
  }

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
    return MultiBlocProvider(
      providers: [
        // TODO: Proper dependency injection! LocalDiscoveryRepository is needed somewhere else in the dashboard screen
        BlocProvider(
          create: (context) => LocalDiscoveryCubit(
            localDiscoveryRepository: LocalDiscoveryRepository(
              // Currently, Dart socket implementation don't support reusePort on:
              //
              // - Android: "Dart Socket ERROR: ../../../flutter/third_party/dart/runtime/bin/socket_linux.cc:157: `reusePort` not supported on this platform."
              // - Windows: "Dart Socket ERROR: ../../../flutter/third_party/dart/runtime/bin/socket_win.cc:192: reusePort not supported for Windows.OK"
              //
              // To workaround, it is disabled only on unsupported platforms.
              // https://github.com/flutter/flutter/issues/27346#issuecomment-560931996
              mDnsClient: MDnsClient(
                rawDatagramSocketFactory: isAndroid || isWindows
                    ? (
                        host,
                        port, {
                        bool? reuseAddress,
                        bool? reusePort,
                        int ttl = 1,
                      }) => RawDatagramSocket.bind(
                        host,
                        port,
                        reuseAddress: true,
                        reusePort: false,
                        ttl: ttl,
                      )
                    : RawDatagramSocket.bind,
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
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
      ),
    );
  }
}
