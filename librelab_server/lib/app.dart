import 'dart:io';

import 'package:librelab_server/app_files.dart';
import 'package:librelab_server/auth/auth_routes.dart';
import 'package:librelab_server/auth/auth_service.dart';
import 'package:librelab_server/auth/authorization_service.dart';
import 'package:librelab_server/auth/security/jwt/jwt_service.dart';
import 'package:librelab_server/auth/security/password_hasher/bcrypt_password_hasher.dart';
import 'package:librelab_server/auth/superuser_initializer.dart';
import 'package:librelab_server/cli/arg_parser.dart';
import 'package:librelab_server/cli/cli_constants.dart';
import 'package:librelab_server/config/config.dart';
import 'package:librelab_server/config/load_app_config.dart';
import 'package:librelab_server/config/load_app_secrets.dart';
import 'package:librelab_server/config/server_run_mode.dart';
import 'package:librelab_server/database/database_connect.dart';
import 'package:librelab_server/database/database_migration_runner.dart';
import 'package:librelab_server/database/database_migrations.g.dart';
import 'package:librelab_server/database/postgres_installer/postgres_installer.dart';
import 'package:librelab_server/generated/pubspec.g.dart';
import 'package:librelab_server/handshake/handshake_routes.dart';
import 'package:librelab_server/mdns/mdns.dart';
import 'package:librelab_server/server/route_module.dart';
import 'package:librelab_server/server/server.dart';
import 'package:librelab_server/user/postgres_user_repository.dart';
import 'package:librelab_server/user/refresh_token/postgres_user_refresh_token_repository.dart';
import 'package:librelab_server/user/user_repository.dart';
import 'package:librelab_server/utils/file_storage/yaml_file_storage.dart';
import 'package:librelab_server/utils/is_debug_mode.dart';
import 'package:librelab_server/utils/platform_check.dart';
import 'package:librelab_server/utils/server_port_availability.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';
import 'package:librelab_server/utils/shutdown/shutdown_hook_registry.dart';
import 'package:logging/logging.dart';

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

  _setupLogger();

  final shutdownHookRegistry = ShutdownHookRegistry();
  final shutdown = Shutdown(hookRegistry: shutdownHookRegistry);

  await _registerProcessShutdownSignalHandlers(shutdown);

  if (argResults.wasParsed(CliOptions.helpFlag)) {
    stderr.writeln(parser.usage);
    await shutdown(isSuccess: true);
  }

  final createSuperUser = argResults.wasParsed(CliOptions.createSuperUserFlag);
  final autoApplyMigrations = argResults.flag(CliOptions.applyMigrationsFlag);

  final workingDirectory = kDebugMode ? Directory('data') : null;
  if (workingDirectory != null && !workingDirectory.existsSync()) {
    await workingDirectory.create();
  }
  final appFiles = AppFiles(workingDirectory: workingDirectory);

  final configRepository = AppConfigRepository(
    file: appFiles.config,
    fileStorage: YamlFileStorage(),
  );

  final config = await loadAppConfig(
    configRepository,
    getConfigFilePath: () => appFiles.config.path,
    shutdown: shutdown,
  );

  final databaseConfig = config.database;
  final isLocalHostDatabase = _isLocalHost(databaseConfig.host);

  final mdnsConfig = configRepository.configOrThrow.mdnsServicePublish;

  final secretsRepository = AppSecretsRepository(
    file: appFiles.secrets,
    fileStorage: YamlFileStorage(),
    platformEnvironment: Platform.environment,
  );

  final secrets = await loadAppSecrets(
    secretsRepository,
    isLocalHostDatabase: isLocalHostDatabase,
    getConfigFilePath: () => appFiles.config.path,
    getSecretsFilePath: () => appFiles.secrets.path,
  );

  await _maybeInstallSystemMdns(
    getConfigFilePath: () => appFiles.config.path,
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
      getConfigFilePath: () => appFiles.config.path,
      shutdown: shutdown,
    );
  }

  final databaseClient = await connectDatabase(
    databaseConfig: databaseConfig,
    password: secrets.databasePassword,
    shutdown: shutdown,
  );
  shutdownHookRegistry.register('closeDatabaseConnection', () async {
    stderr.writeln('Closing the database connection...');
    await databaseClient.close();
  });

  if (autoApplyMigrations) {
    final migrationRunner = DatabaseMigrationRunner(
      client: databaseClient,
      migrations: DatabaseMigrations.list,
      latestVersion: DatabaseMigrations.latest,
      logger: Logger('DatabaseMigrationRunner'),
    );
    await migrationRunner.run();
  }

  final apiServerPort = config.apiServer.listen.port;
  final apiServerAddress = config.apiServer.listen.address;

  await enforcePortAvailability(
    port: apiServerPort,
    getConfigFilePath: () => appFiles.config.path,
    shutdown: shutdown,
  );

  final UserRepository userRepository = PostgresUserRepository(
    client: databaseClient,
  );
  final authService = AuthService(
    passwordHasher: BcryptPasswordHasher(),
    userRepository: userRepository,
    jwtService: JwtService(jwtAccessTokenSecret: secrets.jwtAccessTokenSecret),
    userRefreshTokenRepository: PostgresUserRefreshTokenRepository(
      client: databaseClient,
    ),
  );
  final authorizationService = AuthorizationService(authService: authService);

  final server = await startServer(
    port: apiServerPort,
    address: apiServerAddress,
    routeModules: <RouteModule>[
      HandshakeRoutes(),
      AuthRoutes(service: authService, authorization: authorizationService),
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
    ),
  );
}

void _setupLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final level = record.level;
    final message = '${record.level.name}: ${record.time}: ${record.message}';

    final errorLevels = {Level.WARNING, Level.SEVERE, Level.SHOUT};
    if (errorLevels.contains(level)) {
      final error = record.error;
      final stacktrace = record.stackTrace;

      final messageWithError = StringBuffer('$message\n')
        ..writeAll([
          if (error != null) '  Error: $error\n',
          if (stacktrace != null) '  StackTrace: $stacktrace\n',
        ]);
      stderr.writeln(messageWithError);
    } else {
      stdout.writeln(message);
    }
  });
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
