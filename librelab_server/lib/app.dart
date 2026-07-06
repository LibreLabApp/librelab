import 'dart:io';

import 'package:librelab_server/app_file_paths.dart';
import 'package:librelab_server/audit_log/audit_log_repository_postgres.dart';
import 'package:librelab_server/auth/auth_routes.dart';
import 'package:librelab_server/auth/auth_service/auth_service.dart';
import 'package:librelab_server/auth/authorization_service.dart';
import 'package:librelab_server/auth/login_attempt/login_attempt_repository_postgres.dart';
import 'package:librelab_server/auth/refresh_token/user_refresh_token_repository_postgres.dart';
import 'package:librelab_server/auth/security/jwt/jwt_service.dart';
import 'package:librelab_server/auth/security/password_hasher/bcrypt_password_hasher.dart';
import 'package:librelab_server/auth/superuser_initializer.dart';
import 'package:librelab_server/cli/arg_parser.dart';
import 'package:librelab_server/cli/cli_constants.dart';
import 'package:librelab_server/compatibility/compatibility_routes.dart';
import 'package:librelab_server/config/config.dart';
import 'package:librelab_server/database/database_connect.dart';
import 'package:librelab_server/database/database_migration_runner.dart';
import 'package:librelab_server/database/database_migrations.g.dart';
import 'package:librelab_server/database/postgres_installer/postgres_installer.dart';
import 'package:librelab_server/generated/pubspec.g.dart';
import 'package:librelab_server/lab_settings/lab_settings.dart';
import 'package:librelab_server/lab_settings/lab_settings_repository.dart';
import 'package:librelab_server/lab_settings/lab_settings_repository_postgres.dart';
import 'package:librelab_server/lab_settings/lab_settings_routes.dart';
import 'package:librelab_server/lab_settings/lab_settings_service.dart';
import 'package:librelab_server/mdns/mdns.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/server.dart';
import 'package:librelab_server/user/user_repository.dart';
import 'package:librelab_server/user/user_repository_postgres.dart';
import 'package:librelab_server/utils/is_debug_mode.dart';
import 'package:librelab_server/utils/platform_check.dart';
import 'package:librelab_server/utils/server_port_availability.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';
import 'package:librelab_server/utils/shutdown/shutdown_hook_registry.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';
import 'package:string_storage/string_storage.dart';
import 'package:string_storage/string_storage_file.dart';
import 'package:yaml_storage/yaml_storage.dart';

Future<void> run(List<String> args) async {
  stdout.writeln(
    'Server version: ${Pubspec.version}\n'
    'Arguments: $args\n'
    'Current directory: ${Directory.current.absolute.path}\n'
    'Operating system: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
  );

  final parser = argsParser;
  final argResults = parser.parse(args);

  final serverRunMode = ServerRunMode.fromCliValue(
    argResults.option(CliOptions.serverRunModeOption),
  );

  stdout.writeln('Run mode: ${serverRunMode.name}\n');

  setupLogger((message, {required bool hasError}) {
    if (hasError) {
      stderr.writeln(message);
    } else {
      stdout.writeln(message);
    }
  });

  final shutdownHookRegistry = ShutdownHookRegistry();
  final shutdown = Shutdown(hookRegistry: shutdownHookRegistry);

  await _registerProcessShutdownSignalHandlers(shutdown);

  if (argResults.wasParsed(CliOptions.helpFlag)) {
    stderr.writeln(parser.usage);
    await shutdown(isSuccess: true);
  }

  final createSuperUser = argResults.wasParsed(CliOptions.createSuperUserFlag);
  final autoApplyMigrations = argResults.flag(CliOptions.applyMigrationsFlag);

  final workingDirectory = kDebugMode ? Directory('run_workdir') : null;
  if (workingDirectory != null && !workingDirectory.existsSync()) {
    await workingDirectory.create();
  }
  final appFilePaths = AppFilePaths(workingDirectory: workingDirectory?.path);

  final configDir = Directory(appFilePaths.configDir);
  if (!configDir.existsSync()) {
    await configDir.create();
  }

  final StringStorage stringStorage = StringStorageFile((id) {
    return File(id);
  });

  final yamlStorage = YamlStorage(stringStorage);

  final configRepository = AppConfigRepository(
    storage: yamlStorage,
    storageId: appFilePaths.config,
  );

  final config = await loadAppConfig(
    configRepository,
    getConfigFilePath: () => appFilePaths.config,
    shutdown: shutdown,
  );

  final databaseConfig = config.database;
  final isLocalHostDatabase = _isLocalHost(databaseConfig.host);

  final mdnsConfig = configRepository.cached.mdnsServicePublish;

  final secretsRepository = AppSecretsRepository(
    storage: yamlStorage,
    storageId: appFilePaths.secrets,
    platformEnvironment: Platform.environment,
  );

  final secrets = await loadAppSecrets(
    secretsRepository,
    isLocalHostDatabase: isLocalHostDatabase,
    getConfigFilePath: () => appFilePaths.config,
    getSecretsFilePath: () => appFilePaths.secrets,
  );

  await _maybeInstallSystemMdns(
    getConfigFilePath: () => appFilePaths.config,
    setupPromptDeclinedConfig: config.setupPromptDeclined,
    config: mdnsConfig,
    appConfigRepository: configRepository,
    shutdown: shutdown,
  );

  final shouldShowPostgresInstallPrompt =
      !config.setupPromptDeclined.postgres && isLocalHostDatabase;

  if (shouldShowPostgresInstallPrompt) {
    await tryInstallPostgresWithPrompt(
      appUser: databaseConfig.user,
      appPassword: secrets.databasePassword,
      appDatabaseName: databaseConfig.name,
      onDeclined: () => configRepository.update(
        setupPromptDeclined: config.setupPromptDeclined.copyWith(
          postgres: true,
        ),
      ),
      getConfigFilePath: () => appFilePaths.config,
      shutdown: shutdown,
    );
  }

  final databaseClient = await connectDatabase(
    databaseConfig: databaseConfig,
    password: secrets.databasePassword,
    shutdown: shutdown,
  );
  shutdownHookRegistry.register('closeDatabaseConnections', () async {
    stderr.writeln('Closing the database connections...');
    await databaseClient.close();
  });

  if (autoApplyMigrations) {
    final migrationRunner = DatabaseMigrationRunner(
      db: databaseClient,
      migrations: DatabaseMigrations.list,
      latestVersion: DatabaseMigrations.latest,
      logger: Logger('$DatabaseMigrationRunner'),
    );
    await migrationRunner.run();
  }

  final apiServerPort = config.apiServer.listen.port;
  final apiServerAddress = config.apiServer.listen.address;

  await enforcePortAvailability(
    port: apiServerPort,
    getConfigFilePath: () => appFilePaths.config,
    shutdown: shutdown,
  );

  final LabSettingsRepository labSettingsRepository =
      LabSettingsRepositoryPostgres(databaseClient);

  final labSettings =
      await labSettingsRepository.load() ??
      (await labSettingsRepository.update(const .new()));

  // Calls so that, in case of a bug,
  // it will throw early rather than later.
  if (!identical(labSettingsRepository.cached, labSettings)) {
    throw StateError('$LabSettings were not loaded correctly');
  }

  final UserRepository userRepository = UserRepositoryPostgres(databaseClient);
  final authService = AuthService(
    passwordHasher: BcryptPasswordHasher(),
    jwtService: JwtService(tokenSecret: secrets.jwtAccessTokenSecret),
    userRepository: userRepository,
    userRefreshTokenRepository: UserRefreshTokenRepositoryPostgres(
      databaseClient,
    ),
    loginAttemptRepository: LoginAttemptRepositoryPostgres(databaseClient),
    loginDisabled: () => labSettingsRepository.cached.loginDisabled,
  );
  final authorizationService = AuthorizationService(authService: authService);

  // TODO: (REMOVE_SERVERPOD) Implement global rate limit
  final server = await startServer(
    port: apiServerPort,
    address: apiServerAddress,
    routeModules: <RouteModule>[
      CompatibilityRoutes(),
      AuthRoutes(service: authService, authorization: authorizationService),
      LabSettingsRoutes(
        authorization: authorizationService,
        service: LabSettingsService(
          db: databaseClient,
          labSettingsRepository: labSettingsRepository,
          auditLogRepository: AuditLogRepositoryPostgres(databaseClient),
        ),
      ),
    ],
  );

  shutdownHookRegistry.register('closingHttpServer', () async {
    stderr.writeln('Closing the HTTP server...');
    await server.close();
  });

  if (!createSuperUser && mdnsConfig.enabled) {
    await _registerMdnsService(
      serverPort: apiServerPort,
      shutdownHookRegistry: shutdownHookRegistry,
      instanceName: mdnsConfig.instanceName,
    );
  }

  await _initializeSuperUser(
    forceCreateSuperUser: createSuperUser,
    shutdown: shutdown,
    initializer: SuperUserInitializer(
      repository: userRepository,
      authService: authService,
      shutdown: shutdown,
    ),
  );
}

Future<void> _initializeSuperUser({
  required bool forceCreateSuperUser,
  required SuperUserInitializer initializer,
  required Shutdown shutdown,
}) async {
  if (forceCreateSuperUser) {
    await initializer.createSuperUser();
    await shutdown(isSuccess: true);
  } else {
    await initializer.ensureHasSuperUser();
  }
}

// TODO: (REMOVE_SERVERPOD) Setup the mail service provider and implement
// void _sendPasswordResetCode({
//   required String email,
//   required String verificationCode,
// }) {
//   session.log('[EmailIdp] Password reset code ($email): $verificationCode');
// }

Future<void> _maybeInstallSystemMdns({
  required MdnsServicePublishConfig config,
  required SetupPromptDeclinedConfig setupPromptDeclinedConfig,
  required String Function() getConfigFilePath,
  required AppConfigRepository appConfigRepository,
  required Shutdown shutdown,
}) async {
  if (!config.enabled || setupPromptDeclinedConfig.systemMdnsService) {
    return;
  }
  final platformInstaller = await resolveMdnsPlatformInstaller(
    shutdown: shutdown,
  );
  if (platformInstaller == null) {
    stdout.writeln(
      'Automatic mDNS service installation is not supported by the program on this system.',
    );
    return;
  }
  final installer = MdnsInstaller(
    platform: platformInstaller,
    getConfigFilePath: getConfigFilePath,
  );
  await installer.tryInstallWithPrompt(
    onDeclined: () => appConfigRepository.update(
      setupPromptDeclined: setupPromptDeclinedConfig.copyWith(
        systemMdnsService: true,
      ),
    ),
  );
}

Future<void> _registerMdnsService({
  required int serverPort,
  required ShutdownHookRegistry shutdownHookRegistry,
  required String instanceName,
}) async {
  final registrar = MdnsServiceRegistrar(
    platform: await resolveMdnsPlatformRegistrar(),
  );
  await registrar.start(port: serverPort, instanceName: instanceName);

  shutdownHookRegistry.register('stoppingMdnsService', () async {
    stdout.writeln('Stopping mDNS service...');
    await registrar.stop();
  });
}

Future<void> _registerProcessShutdownSignalHandlers(Shutdown shutdown) async {
  Future<void> handleSignal(ProcessSignal signal) async {
    stdout.writeln('Received signal: $signal');
    await shutdown(isSuccess: true);
  }

  ProcessSignal.sigint.watch().listen(handleSignal);

  if (!isWindows) {
    ProcessSignal.sigterm.watch().listen(handleSignal);
  }
}

bool _isLocalHost(String host) {
  const localHosts = {'localhost', '127.0.0.1', '::1'};
  final normalizedHost = host.trim().toLowerCase();
  return localHosts.contains(normalizedHost);
}
