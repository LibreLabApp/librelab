import 'dart:io' show stderr, stdout;

import 'package:api_client/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage_linux_portal/flutter_secure_storage_linux_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:json_storage/json_storage.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/app_file_paths.dart';
import 'package:librelab_flutter/app_settings/app_settings.dart';
import 'package:librelab_flutter/app_settings/app_settings_repository.dart';
import 'package:librelab_flutter/app_settings/ui/cubit/app_settings_cubit.dart';
import 'package:librelab_flutter/auth/auth_deps_provider.dart';
import 'package:librelab_flutter/auth/auth_repository/auth_repository.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:librelab_flutter/common/network/http_client_deps_provider.dart';
import 'package:librelab_flutter/common/network/http_client_factory/http_client_factory.dart';
import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_flutter/common/secure_storage/freedesktop_secret_service_checker.dart';
import 'package:librelab_flutter/common/secure_storage/secure_storage.dart';
import 'package:librelab_flutter/common/secure_storage/secure_storage_availability_checker.dart';
import 'package:librelab_flutter/common/ui/go_router_utils.dart';
import 'package:librelab_flutter/common/ui/window_close_handler.dart';
import 'package:librelab_flutter/file_storage/file_storage_repository.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart' hide AppLocale;
import 'package:librelab_flutter/home/home_page.dart';
import 'package:librelab_flutter/initial_setup/initial_setup_page.dart';
import 'package:librelab_flutter/login_identity/cubit/login_identity_cubit.dart';
import 'package:librelab_flutter/login_identity/login_identity_deps_provider.dart';
import 'package:librelab_flutter/login_identity/login_identity_repository/auth_secure_storage.dart';
import 'package:librelab_flutter/login_identity/login_identity_repository/login_identity_repository.dart';
import 'package:librelab_flutter/login_identity/login_identity_service.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:string_storage/string_storage_file.dart';
import 'package:string_storage_shared_preferences/string_storage_shared_preferences.dart';
import 'package:system_accent_color/system_accent_color.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey();

final _logger = Logger('Main');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger((message, {required bool hasError}) {
    if (isMobile || kIsWeb) {
      debugPrint(message);
      return;
    }

    if (hasError) {
      stderr.writeln(message);
    } else {
      stdout.writeln(message);
    }
  });

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

  final FreedesktopSecretServiceChecker freedesktopSecretServiceChecker =
      FreedesktopSecretServiceCheckerImpl();

  if (isLinux &&
      (await freedesktopSecretServiceChecker.getAvailableServices())
          .hasSecretPortalWithoutSecretService) {
    FlutterSecureStorageLinuxPortal.registerWith();
    _logger.fine(
      'Using XDG Secret Portal to provide the application-scoped encryption secret.',
    );
  }

  final SecureStorageAvailabilityChecker secureStorageAvailabilityChecker =
      SecureStorageAvailabilityCheckerImpl(
        freedesktopSecretServiceChecker: freedesktopSecretServiceChecker,
      );

  final secureStorageAvailability = await secureStorageAvailabilityChecker
      .getAvailability();
  if (!secureStorageAvailability.isAvailable) {
    _logger.warning(
      'SECURITY WARNING: Secure storage is unavailable. Authentication tokens '
      'will be stored in a plain text file unencrypted.',
    );
  }

  final SecureStorage secureStorage = SecureStorageImpl(
    flutterSecureStorage: const FlutterSecureStorage(
      mOptions: MacOsOptions(
        // Data Protection Keychain requires Keychain Sharing, which requires
        // app registration with Apple. The app is not registered yet.
        //
        // Once the app is registered, this can be removed to use the Data
        // Protection Keychain.
        //
        // Details: https://pub.dev/packages/flutter_secure_storage#macos-keychain-sharing-requires-provisioning
        usesDataProtectionKeychain: false,
        accountName: ProjectConstants.appleKeychainAppName,
      ),
      iOptions: IOSOptions(accountName: ProjectConstants.appleKeychainAppName),
    ),
  );

  final settingsRepository = AppSettingsRepository(
    storage: jsonStorage,
    storageId: filePaths.settings,
  );

  // TODO: Handle loading/parsing failure (since it loads a file from disk).
  await settingsRepository.load();
  final settings = settingsRepository.cached;

  await _setLocale(settings.locale);

  final httpClient = createHttpClient();
  final httpApiClient = HttpApiClientDart(httpClient);

  final libreLabApiClient = LibreLabApiClient(
    apiClient: httpApiClient,
    logger: Logger('LibreLabApiClient'),
  );

  final apiRequestHandler = ApiRequestHandlerDefault(
    logger: Logger('ApiRequestHandlerDefault'),
  );

  final authRepository = AuthRepository(
    authEndpoints: libreLabApiClient.endpoints.auth,
    handler: apiRequestHandler,
  );

  final loginIdentityCubit = LoginIdentityCubit(
    service: LoginIdentityService(
      client: libreLabApiClient,
      loginIdentityRepository: LoginIdentityRepository(
        storage: jsonStorage,
        storageId: filePaths.loginIdentities,
        secureStorage: AuthSecureStorageImpl(secureStorage: secureStorage),
        secureStorageAvailable: secureStorageAvailability.isAvailable,
      ),
    ),
    logger: Logger('LoginIdentityCubit'),
    authRepository: authRepository,
  );

  // TODO: Handle loading/parsing failure (since it loads a file from disk).
  //  it is currently only handled in initial setup page.
  await loginIdentityCubit.load();

  libreLabApiClient.setOnAuthSessionRefreshed((session) async {
    if (!_hasPersistedLoginIdentity(session.userId, loginIdentityCubit)) {
      return;
    }

    await loginIdentityCubit.updateAuthSession(session.userId, session);
  });

  apiRequestHandler.setOnSessionInvalidated((e) async {
    if (!_hasPersistedLoginIdentity(e.session.userId, loginIdentityCubit)) {
      return;
    }

    await loginIdentityCubit.markReauthenticationRequired(e.session.userId);
  });

  final router = GoRouter(
    navigatorKey: _navKey,
    routes: [
      GoRoute(
        path: InitialSetupPage.routePath,
        builder: (context, state) => const InitialSetupPage(),
      ),
      GoRoute(
        path: HomePage.routePath,
        builder: (context, state) => const HomePage(),
      ),
    ],
    refreshListenable: GoRouterRefreshStream([
      loginIdentityCubit.stream.distinct((previous, current) {
        bool hasSelectedLoginIdentity(LoadLoginIdentitiesState state) =>
            state is LoadLoginIdentitiesSuccess &&
            state.selectedLoginIdentity != null;

        return hasSelectedLoginIdentity(previous.loadState) ==
            hasSelectedLoginIdentity(current.loadState);
      }),
    ]),
    redirect: (context, state) {
      final loginIdentityState = loginIdentityCubit.state.loadState;

      if (loginIdentityState is LoadLoginIdentitiesSuccess &&
          loginIdentityState.selectedLoginIdentity != null) {
        return HomePage.routePath;
      }
      return InitialSetupPage.routePath;
    },
  );

  final systemAccentColor = await SystemAccentColor().getAccentColor();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppFilePaths>.value(value: filePaths),
        HttpClientDepsProvider(
          httpClient: httpClient,
          httpApiClient: httpApiClient,
          libreLabApiClient: libreLabApiClient,
          apiRequestHandler: apiRequestHandler,
        ),
        AuthDepsProvider(authRepository: authRepository),
        LoginIdentityDepsProvider(loginIdentityCubit: loginIdentityCubit),
        BlocProvider<AppSettingsCubit>(
          create: (context) =>
              AppSettingsCubit(settingsRepository, initial: settings),
        ),
        RepositoryProvider<FileStorageRepository>(
          create: (context) => FileStorageRepository(
            fileStorageEndpoints: libreLabApiClient.endpoints.fileStorage,
            handler: apiRequestHandler,
          ),
        ),
        Provider<SecureStorageAvailability>.value(
          // Resolved once at startup and remains unchanged for the application lifetime.
          value: secureStorageAvailability,
        ),
      ],
      child: TranslationProvider(
        child: MainApp(router: router, systemAccentColor: systemAccentColor),
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

class const MainApp({
  required final GoRouter _router,
  required final Color? _systemAccentColor,
  super.key,
}) extends StatelessWidget {
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
                    final color = _systemAccentColor;
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
            title: ProjectConstants.displayName,
            debugShowCheckedModeBanner: false,
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
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
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

/// Whether a persisted login identity exists for [userId].
///
/// During initial setup, authentication may be required before the login
/// identity is persisted. If this returns `false`, do not update the login
/// identity for [userId].
bool _hasPersistedLoginIdentity(
  String userId,
  LoginIdentityCubit loginIdentityCubit,
) {
  final loadState = loginIdentityCubit.state.loadState;
  if (loadState is! LoadLoginIdentitiesSuccess) {
    return false;
  }

  return loadState.loginIdentities.list.any(
    (identity) => identity.user.id == userId,
  );
}
