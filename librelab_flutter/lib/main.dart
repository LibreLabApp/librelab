import 'dart:async';
import 'dart:convert';
import 'dart:io' show File, Platform, stderr, stdout;

import 'package:connectivity_plus_linux_portal/connectivity_plus_linux_portal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalMaterialLocalizations;
import 'package:go_router/go_router.dart';
import 'package:librelab_client/librelab_client.dart';
import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_flutter/common/ui/window_close_handler.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart';
import 'package:librelab_flutter/initial_setup/initial_setup_page.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/cubit/local_discovery_cubit.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/mdns_service_discovery_resolver.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/repository.dart';
import 'package:librelab_flutter/server_connection/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:logging/logging.dart';
import 'package:mdns_discovery/mdns_discovery.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// Will be removed later (temporary for testing purposes)
late final Client client;

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

  if (isLinux) {
    _maybeUseNetworkMonitorPortal();
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

  runApp(
    TranslationProvider(
      child: MainApp(discovery: await resolveMdnsServiceDiscoveryImpl()),
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
  const MainApp({super.key, required this._discovery});

  final MdnsServiceDiscovery _discovery;

  @override
  Widget build(BuildContext context) {
    final listTileTheme = ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LocalDiscoveryRepository(
            logger: Logger('$LocalDiscoveryRepository'),
            discovery: _discovery,
          ),
          // TODO: (MDNS) We probably want to dispose this when we are no longer in the "Available servers" screen? Reopen as needed
          dispose: (repository) => repository.close(),
        ),
        BlocProvider(
          create: (context) =>
              LocalDiscoveryCubit(localDiscoveryRepository: context.read()),
        ),
        BlocProvider(create: (context) => ServerSelectionCubit()),
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
